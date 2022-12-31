#include<stdio.h> 
#include<string.h> 
int main()
{    
	char s[] = "hello";
	char *p = strchr(s, 'l');//寻找第一个l 
	printf("%s\n", p);
	p = strchr(p+1, 'l');//寻找第二个l 
	printf("%s\n", p);
	return 0;   
}

