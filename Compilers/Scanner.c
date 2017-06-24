#include <stdio.h>
#include <string.h>
#include <ctype.h>

int reserve(char *token);
void connect(char *token, char c);
void retract(char c, char *token);
void error(int count, int type);
char c = '\0';	//the latest character
char token[30] = "\0";	//the latest word
int count = 1;		//the number of lines
int flag = 0;		//0 means there is no retract

int main()
{	
	freopen("program.pas", "r", stdin);
	freopen("two_element.dyd", "w", stdout);

	//clear/earse the .err
	FILE *fp;
	fp = fopen("scanner.err", "w");
	fclose(fp);
	
	c = getchar();		
	while (1) {		
		/*	once get a word, token will be void
			if not, there is a retract 
			so take back the retracted character	*/
		if (token[0] != '\0') {
			c = token[0];
			token[0] = '\0';
		}			
		
		//skip blocks
		while (c == '\n' || c == ' ' || c == '\t') {	
			if (c == '\n') {
				printf("%16s 24\n", "EOLN");
				count++;
			}			
			c = getchar();
		}
		
		//identify	
		if (isalpha(c)) {
			do {
				connect(token, c);
				c = getchar();	
			} while (isalpha(c) || isdigit(c));			
			
			//output the result --- identifier or reserve
			int judge = reserve(token);
			if (judge == 0)
				printf("%16s 10\n", token);
			else
				printf("%16s  %d\n", token, judge);
			memset(token, '\0', sizeof(token));
			retract(c, token);
				
		} else if (isdigit(c)) {
			do {
				connect(token, c);
				c = getchar();
			} while (isdigit(c));
			
			//output the result --- integer
			int len = strlen(token);
			for (int j = 0; j < 16 - len; j++)
				printf(" ");
			for (int i = 0; i < len; i++)
				printf("%c", token[i]);
			printf(" 11\n");
			memset(token, '\0', sizeof(token));
			retract(c, token);
				
		} else {
			switch(c) {
				case '=':
					printf("%16c 12\n", '=');
					break;
				case '-':
					printf("%16c 18\n", '-');
					break;
				case '*':
					printf("%16c 19\n", '*');
					break;
				case '(':
					printf("%16c 21\n", '(');
					break;
				case ')':
					printf("%16c 22\n", ')');
					break;
				case ';':
					printf("%16c 23\n", ';');
					break;
				case '<':					
					c = getchar();
					if (c == '=')
						printf("%16s 14\n", "<=");
					else if (c == '>')
						printf("%16s 13\n", "<>");
					else {
						printf("%16c 15\n", '<');
						retract(c, token);
					}
					break;
				case '>':
					c = getchar();
					if (c == '=')
						printf("%16s 16\n", ">=");
					else {
						printf("%16c 17\n", '>');
						retract(c, token);
					}
					break;
				case ':':
					c = getchar();
					if (c == '=')
						printf("%16s 20\n", ":=");
					else {
						retract(c, token);
						error(count, 0);
					}						
					break;
				default:
					if (c != -1) {
						error(count, 1);
				//		retract(c, token);
					}						
					break;
			}
		}
		
		//if there is a retract already, skip once
		if (flag == 1) {
			flag = 0;
			continue;
		}
		
		//readin next character
		//if in the end, print EOF
		if ((c = getchar()) == EOF) {
			printf("%16s 25\n", "EOF");
			break;
		}
	}
    
    fclose(stdin);
	fclose(stdout);
	 
    return 0;
}

void error(int count, int type)
{	
	FILE *fp;
	fp = fopen("scanner.err", "a");
	if (type == 0)
		fprintf(fp, "***LINE:%d  mismatch colon\n", count);
	else
		fprintf(fp, "***LINE:%d  illegal character '%c'\n", count, c);
	fclose(fp);
}

void retract(char c, char *token)
{
	token[0] = c;
	c = '\0';
	flag = 1;
}

void connect(char *token, char c)
{
	int len = strlen(token);
	token[len] = c;
}

int reserve(char token[])
{
	char *res[10];
//	memset(res, '\0', sizeof(res));
	res[1] = "begin";
	res[2] = "end";
	res[3] = "integer";
	res[4] = "if";
	res[5] = "then";
	res[6] = "else";
	res[7] = "function";
	res[8] = "read";
	res[9] = "write";
	/*	if the word is a reserve,
		return its type number,
		if not, return 0	*/
	for (int i = 1; i <= 9; i++)
		if(!strcmp(res[i], token))
			return i;
	return 0;
}
