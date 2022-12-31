#include<stdio.h>
int lcm(int a, int b)
{
	int r=0,c;
	c=a>b?a:b;
	b=a+b-c;
	a=c;
	do{
		r=a%b;
		a=b;
		b=r;
	}while(r!=0);
	return a;
}
unsigned int gcd(int a, int b)
{
	unsigned int c;
	c=a*b/lcm(a,b);
	return c;
}
void main()
{
	int n=1,i=0;
	scanf("%d", &n);
	unsigned int res[n][2];
	int a,b;
	for(; i<n;i++){
		scanf("%d %d", &a, &b);
		res[i][1]=lcm(a,b);
		res[i][2]=gcd(a,b);
	}
	for(i=0;i<n;i++){
		printf("%d %d\n", res[i][1], res[i][2]);
	}
} 
