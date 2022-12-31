#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void reg_num(char *r);
void zero_extend();
void sign_extend();

char rd[10] = "\0", rs[10] = "\0", rt[10] = "\0";
int imm = 0, add = 0;

int main()
{
	freopen("instruction.txt", "r", stdin);
//	freopen("binary.txt", "w", stdout);
	printf("%6s%6s%5s%5s%5s%5s\n", "31:26", "35:20", "19:15", "14:10", "9:5", "4:0");
	
	char ins[10] = "\0";
	
	while (scanf("%s", ins) != EOF) {
		if (strcmpi(ins, "add") == 0) {
			printf("00000000000100000");
			reg_num(rd);
			reg_num(rs);
			reg_num(rt);
			printf("%s%s%s\n", rd, rs, rt);
		} else if (strcmpi(ins, "and") == 0) {
			printf("00000100000100000");
			reg_num(rd);
			reg_num(rs);
			reg_num(rt);
			printf("%s%s%s\n", rd, rs, rt);
		} else if (strcmpi(ins, "or") == 0) {
			printf("00000100001000000");
			reg_num(rd);
			reg_num(rs);
			reg_num(rt);
			printf("%s%s%s\n", rd, rs, rt);
		} else if (strcmpi(ins, "xor") == 0) {
			printf("00000100010000000");
			reg_num(rd);
			reg_num(rs);
			reg_num(rt);
			printf("%s%s%s\n", rd, rs, rt);
		} else if (strcmpi(ins, "sra") == 0) {
			printf("000010000001");
			reg_num(rd);
			reg_num(rt);
			reg_num(rs);	//shift
			printf("%s%s00000%s\n", rs, rd, rt);
		} else if (strcmpi(ins, "srl") == 0) {
			printf("000010000010");
			reg_num(rd);
			reg_num(rt);
			reg_num(rs);	//shift
			printf("%s%s00000%s\n", rs, rd, rt);
		} else if (strcmpi(ins, "sll") == 0) {
			printf("000010000011");
			reg_num(rd);
			reg_num(rt);
			reg_num(rs);	//shift
			printf("%s%s00000%s\n", rs, rd, rt);
		} else if (strcmpi(ins, "addi") == 0) {
			printf("000101");
			reg_num(rt);
			reg_num(rs);
			sign_extend();
			printf("%s%s\n", rs, rt);
		} else if (strcmpi(ins, "andi") == 0) {
			printf("001001");
			zero_extend();
		} else if (strcmpi(ins, "ori") == 0) {
			printf("001010");
			zero_extend();
		} else if (strcmpi(ins, "xori") == 0) {
			printf("001100");
			zero_extend();
		} else if (strcmpi(ins, "load") == 0) {
			printf("001101");
			reg_num(rt);
			sign_extend();
			getchar();	//input '('
			reg_num(rs);
			getchar();	//input ')'
			printf("%s%s\n", rs, rt);
		} else if (strcmpi(ins, "store") == 0) {
			printf("001110");
			reg_num(rt);
			sign_extend();
			getchar();	//input '('
			reg_num(rs);
			getchar();	//input ')'
			printf("%s%s\n", rs, rt);
		} else if (strcmpi(ins, "beq") == 0) {
			printf("001111");
			reg_num(rt);
			reg_num(rs);
			sign_extend();
			printf("%s%s\n", rs, rt);
		} else if (strcmpi(ins, "bne") == 0) {
			printf("010000");
			reg_num(rt);
			reg_num(rs);
			sign_extend();
			printf("%s%s\n", rs, rt);
		} else if (strcmpi(ins, "jump") == 0) {
			printf("010010");
			
			scanf("%d", &add);
			char tem_add[30] = "\0";
			itoa(add, tem_add, 2);
			for (unsigned int k = 26; k > strlen(tem_add); k--)
				printf("0");
			
			printf("%s\n", tem_add);
		} else
			printf("Wrong instruction!\n");
	}
	
	return 0;
}

void reg_num(char *r) {
	memset(r, '\0', strlen(r));
	int num_r = 0;
	char tem_r[6] = "\0";
	getchar();	//erase ' ' or ','
	getchar();	//erase 'r'
	scanf("%d", &num_r);
	itoa(num_r, tem_r, 2);
	for (unsigned int k = 5; k > strlen(tem_r); k--)
		r[5 - k] = '0';
	strcat(r, tem_r);
}

void sign_extend() {
	getchar();	//erase ','
	scanf("%d", &imm);
	
	char tem_i[40] = "\0";
	itoa(imm, tem_i, 2);
	//负数的情况，itoa()会把它符号扩展成32位的二进制 
	if (imm < 0) {
		for (int k = 16; k <= 31; k++)	//取后16位即可 
			printf("%c", tem_i[k]);
	} else {
		for (unsigned int k = 16; k > strlen(tem_i); k--)
			printf("0");
		printf("%s", tem_i);
	}
}

void zero_extend() {
	reg_num(rt);
	reg_num(rs);
		
	getchar();	//erase ','
	scanf("%d", &imm);
	
	char tem_i[20] = "\0";
	itoa(imm, tem_i, 2);
	for (unsigned int k = 16; k > strlen(tem_i); k--)
		printf("0");
	printf("%s", tem_i);
	
	printf("%s%s\n", rs, rt);
}
