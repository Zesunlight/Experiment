#include <stdio.h>

typedef struct {	//table of variables
	char name[16];
	int proc;	//belongs to which process
	int kind;	//0 means a varible, 1 means a parameter
	char type[6];
	int level;	//level = 0 means it belongs to main process
	int address;	//1 means the first varible, actually don't need it
}Var;
Var table_var[200];

typedef struct {	//table of processes
	char name[16];
	char type[6];
	int level;	//levle = 0 means it is main()
	int fadr;	//address of the first variable which in this process 
	int ladr;	//address of the last variable which in this process
}Proc;
Proc table_proc[100];

struct proc {	//order of processes
	int number;
	struct proc *latter;
	struct proc *former;
};
struct proc *head, *now_proc;	
//now_proc means now location is in process number

int num_var = 0;	//the number of variable, begin at 1
int level = 0;		//the level of variable and process
int num_proc = 0;	//the number of process, begin at 0
int count = 1;		//the number of lines
char word[16] = "\0";	//get from two_element
int label = 0;			//get from two_element

int skip = 0;
void next_duality()	{	//get the next two_element and skip EOLN
	if (skip == 0) {
		scanf("%s%d", word, &label);
		while (label == 24) {
			scanf("%s%d", word, &label);
			count++;
		}	
	} else
		skip = 0;
}

void Process();		//Process() -> begin Captions() Implements() end
void Captions();	//Captions() -> caption() ; extra_cap()
void caption();		//caption() -> variable() | funcation()
void extra_cap();	//extra_cap() -> void | caption() ; extra_cap()
void var_or_func();	//var_or_func() -> variable() | function cap_func()
void variable();	//variable() -> identifier
void cap_func();	//cap_func() -> identifier ( parameter() ) ; function()
void parameter();	//parameter() -> variable()
void function();	//function() -> begin Captions() Implements() end
void Implements();	//Implements() -> implement() extra_imp()
void implement();	//implement() -> read() | write() | assign() | require()
void extra_imp();	//extra_imp() -> void | ; implement() extra_imp()
void used_var();
void read();		//read() -> read ( used_var() )
void write();		//write() -> write ( used_var() )
void assign();		//assign() -> used_var() := calculate()
void require();		//require() -> if condition() then implement() else implement()
void condition();	//condition() -> calculate() relation() calculate()
void relation();	//relation() -> < | <= | > | >= | = | <>
void calculate();	//calculate() -> item() extra_cal()
void extra_cal();	//extra_cal() -> void | - item() extra_cal()
void item();		//item() -> factor() extra_item()
void factor();		//factor() -> used_var() | const | used_func()
void used_func();
void extra_item();	//extra_item() -> void | * factor() extra_item()
