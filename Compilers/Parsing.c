#include <stdlib.h>
#include <string.h>
#include "parse.h"

int main()
{
	//copy .dyd to .dys 
	FILE *fp = fopen("two_element.dyd", "r");
	FILE *fp2 = fopen("parsing.dys", "w");
	char ch;
	while((ch = fgetc(fp) )!= EOF)
	    fputc(ch, fp2);
	fclose(fp);
	fclose(fp2);
	
	freopen("parsing.dys", "r", stdin);
	freopen("scanner.err", "a", stdout);	
		
	Process();
	
	//erase former data 
	fp = fopen("parsing.var", "w");
	fclose(fp);
	fp = fopen("parsing.pro", "w");
	fclose(fp);
	
	int first = -1;
	fp = fopen("parsing.var", "a");
	fprintf(fp, "%8s%8s%8s%8s%8s%8s\n", "name", "type", "proc", "level", "kind", "address");
	for (int i = 1; i <= num_var; i++) {
		fprintf(fp, "%8s%8s%8d", table_var[i].name, table_var[i].type, table_var[i].proc);
		
		if (first != table_var[i].proc)
			table_proc[table_var[i].proc].fadr = i;
		table_proc[table_var[i].proc].ladr = i;
		
		fprintf(fp, "%8d%8d%8d\n", table_var[i].level, table_var[i].kind, table_var[i].address);
		first = table_var[i].proc;
	}
	fclose(fp);
	
	fp = fopen("parsing.pro", "a");
	fprintf(fp, "%8s%8s%8s%8s%8s\n", "name", "type", "level", "fadr", "ladr");
	for (int i = 0; i <= num_proc; i++) {
		fprintf(fp, "%8s%8s", table_proc[i].name, table_proc[i].type);
		fprintf(fp, "%8d%8d%8d\n", table_proc[i].level, table_proc[i].fadr, table_proc[i].ladr);
	}
	fclose(fp);
	
	return 0;
}

void Process() {		//Process() -> begin Captions() Implements() end
	next_duality();
	//judge "begin"	
	if (label != 1)
		printf("***LINE:%d  expected 'begin' of main process\n", count);
			
	//record the main process
	strcpy(table_proc[num_proc].name, "main");
	strcpy(table_proc[num_proc].type, "ints");
	table_proc[num_proc].level = 0;
	
	//first process number is 0, also the first node
	head = (struct proc*)malloc(sizeof(struct proc*));
	head->number = 0;
	head->latter = NULL;
	head->former = NULL;
	now_proc = head;
	
	Captions();
	Implements();
		
	//judge "end"
	next_duality();
	if (label != 2) {
		printf("***LINE:%d  expected an 'end' of main process\n", count);
	} else {
		next_duality();
		//it's time to end this program
		if (label != 25)
			printf("***LINE:%d  there should be no character after 'end'\n", count);
	}
	
	free(head);
}
void Captions() {		//Captions() -> caption() ; extra_cap()
	next_duality();	
	caption();
	
	//judge ';'
	next_duality();
	if (label != 23)
		printf("***LINE:%d  expected ';' after this caption\n", count);
		
	extra_cap();
}
void caption() {		//caption() -> integer var_or_func()
	//judge "integer"
	if (label != 3)
		printf("***LINE:%d  expected 'integer' of this caption\n", count);
	
	var_or_func();
}
void extra_cap() {		//extra_cap() -> void | caption() ; extra_cap()
	next_duality();
	if (label == 3) {
		caption();
		
		next_duality();
		if (label != 23)
			printf("***LINE:%d  expected ';' after this caption\n", count);
			
		extra_cap();
	}
	skip = 1;
}
void var_or_func() {	//var_or_func() -> variable() | function cap_func()
	next_duality();
	if (label == 7)
		cap_func();
	else
		variable();
}
void variable() {		//variable() -> identifier
	if (label != 10)
		printf("***LINE:%d  '%s' is not a valid variable name\n", count, word);
	
	//judge this variable had been defined or not
	int flag = 1;
	for (int i = 1; i <= num_var; i++) {
		if (strcmp(table_var[i].name, word) == 0 && table_var[num_var].kind == 0) {
			printf("***LINE:%d  '%s' redefined this variable\n", count, word);
			flag = 0;
		}		
	}
	
	//store it to table_var
	if (flag) {
		num_var++;
		table_var[num_var].kind = 0;
		table_var[num_var].level = level;
		table_var[num_var].proc = now_proc->number;
		strcpy(table_var[num_var].name, word);
		strcpy(table_var[num_var].type, "ints");
		table_var[num_var].address = num_var;
	}	
}
void cap_func() {		//cap_func() -> identifier ( parameter() ) ; function()
	next_duality();
	if (label != 10)
		printf("***LINE:%d  not a valid function name\n", count);

	num_proc++;	//a new process
	level++;	//enter in a function
	strcpy(table_proc[num_proc].name, word);
	strcpy(table_proc[num_proc].type, "ints");
	table_proc[num_proc].level = level;
	
	//considered now has entered this process
	struct proc *temp;
	temp = (struct proc*)malloc(sizeof(struct proc*));
	now_proc->latter = temp;
	temp->number = num_proc;
	temp->latter = NULL;
	temp->former = now_proc;
	now_proc = temp;
	
	next_duality();
	if (label != 21)
		printf("***LINE:%d  expected a '('\n", count);
	
	parameter();
	
	next_duality();
	if (label != 22)
		printf("***LINE:%d  expected a ')'\n", count);
		
	next_duality();
	if (label != 23)
		printf("***LINE:%d  expected a ';'\n", count);	
		
	function();				
}
void parameter() {		//parameter() -> variable()
	next_duality();
	table_var[num_var].kind = 1;
	variable();
	table_var[num_var].kind = 1;	
}
void function() {		//function() -> begin Captions() Implements() end
	next_duality(); 
	//judge "begin"
	if (label != 1)
		printf("***LINE:%d  expected 'begin' of the function\n", count);
	
	Captions();
	Implements();
		
	//judge "end"
	next_duality();
	if (label != 2)
		printf("***LINE:%d  expected 'end' of this function\n", count);
		
	level--;	//exit the function
	struct proc *temp;
	temp = now_proc;
	now_proc = temp->former;
	free(temp);	
}
void Implements() {		//Implements() -> implement() extra_imp()
	next_duality();
	implement();
	extra_imp();
}
void implement() {		//implement() -> read() | write() | assign() | require()
	switch(label) {
		case 8:
			read();
			break;
		case 9:
			write();
			break;
		case 4:
			require();
			break;
		case 10:
			assign();
			break;
		default:
			printf("***LINE:%d  '%s' is not a valid implement\n", count, word);
			break;	
	}
}
void extra_imp() {		//extra_imp() -> void | ; implement() extra_imp()
	next_duality();
	if (label == 23) {
		next_duality();
		implement();
		extra_imp();
	}
	skip = 1;
}
void used_var() {
	next_duality();
	int flag = 0;
	for (int i = 1; i <= num_var; i++) {
		if (strcmp(table_var[i].name, word) == 0)
			//belongs to this function or is a relative external variable
		//	if (level < table_var[i].level)
				flag = 1;	
	}
	
	if (flag == 0)
		printf("***LINE:%d  '%s' undeclared(in this function)\n", count, word);
}
void read() {			//read() -> read ( used_var() )
	next_duality();
	if (label != 21)
		printf("***LINE:%d  expected '(' after 'read'\n", count);
		
	next_duality();
	if (label != 10)
		printf("***LINE:%d  not a valid variable name\n", count);
	skip = 1;
	used_var();
	
	next_duality();
	if (label != 22)
		printf("***LINE:%d  expected ')'\n", count);
}
void write() {			//write() -> write ( used_var() )
	next_duality();
	if (label != 21)
		printf("***LINE:%d  expected '(' after 'write'\n", count);
		
	next_duality();
	if (label != 10)
		printf("***LINE:%d  not a valid variable name\n", count);
	skip = 1; 
	used_var();
	
	next_duality();
	if (label != 22)
		printf("***LINE:%d  expected ')'\n", count);
}
void require() {		//require() -> if condition() then implement() else implement()
	condition();
	
	next_duality();
	if (label != 5)
		printf("***LINE:%d  expected 'then'\n", count);
	
	next_duality();	
	implement();
	
	next_duality();
	if (label != 6)
		printf("***LINE:%d  expected 'else'\n", count);
	
	next_duality();	
	implement();
}
void condition() {		//condition() -> calculate() relation() calculate()
	calculate();
	relation();
	calculate();
}
void relation() {		//relation() -> < | <= | > | >= | = | <>
	next_duality();
	if (!(label <= 17 && label >= 12))
		printf("***LINE:%d  '%s' is not a valid relational operation\n", count, word);
}
void assign() {			//assign() -> used_var() := calculate()
	skip = 1; 
	used_var();
	
	next_duality();
	if (label != 20)
		printf("***LINE:%d  expected ':='\n", count);
		
	calculate();
}
void calculate() {		//calculate() -> item() extra_cal()
	item();
	extra_cal();
}
void extra_cal() {		//extra_cal() -> void | - item() extra_cal()
	next_duality();
	if (label == 18) {
		item();
		extra_cal();
	} else
		skip = 1;	
}
void item() {			//item() -> factor() extra_item()
	factor();
	extra_item();
}
void factor() {			//factor() -> used_var() | const | used_func()
	next_duality();
	if (label != 11 && label != 10)
		printf("***LINE:%d  not a valid factor\n", count);
		
	if (label == 10) {
		char tem_word[16];
		int tem_label;
		scanf("%s%d", tem_word, &tem_label);
		while (tem_label == 24) {
			scanf("%s%d", tem_word, &tem_label);
			count++;
		}
		
		if (tem_label == 21)
			used_func();
		else {
			skip = 1;
			used_var();
			strcpy(word, tem_word);
			label = tem_label;
			skip = 1;
		}
	}
}
void used_func() {
	int flag = 0;
	for (int i = 1; i <= num_proc; i++) {
		if (strcmp(table_proc[i].name, word) == 0)
			flag = 1;
	}
	if (flag == 0)
		printf("***LINE:%d  function '%s' undeclared\n", count, word);
	
	next_duality();
	if (label != 11) {
		if (label == 10) {
			skip = 1;
			used_var();
		} else
			printf("***LINE:%d  '%s' is not a valid parameter\n", count, word);			
	}
	
	next_duality();
	if (label != 22)
		printf("***LINE:%d  expected ')'\n", count);
}
void extra_item() {		//extra_item() -> void | * factor() extra_item()
	next_duality();
	if (label == 19) {
		factor();
		extra_item();
	} else
		skip = 1;
}










