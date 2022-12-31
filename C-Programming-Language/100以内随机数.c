#include<stdio.h>
#include<stdlib.h>
#include<time.h>
void main()
{
	srand(time(0));
	int a = rand();
	
	printf("%d\n", a%100);
 } 
