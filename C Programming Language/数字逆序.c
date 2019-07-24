#include<stdio.h>
void main()
{
	int x;
	scanf("%d", &x);
	
	int digit, ret=0;
	for( ; x>0; x/=10){
		digit = x%10;
		printf("%d", digit);//末尾的0也输出 
		//ret = ret*10 + digit;	//计算逆序的数字 
	}
	//printf("%d", ret);//末尾的0不输出 
 } 
