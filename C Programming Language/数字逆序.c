#include<stdio.h>
void main()
{
	int x;
	scanf("%d", &x);
	
	int digit, ret=0;
	for( ; x>0; x/=10){
		digit = x%10;
		printf("%d", digit);//ĩβ��0Ҳ��� 
		//ret = ret*10 + digit;	//������������� 
	}
	//printf("%d", ret);//ĩβ��0����� 
 } 
