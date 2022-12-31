#include<stdio.h>
void main()
{
	int x, t;
	scanf("%d", &x );
	t = x;
	
	int mask = 1 ;
	while ( x>9 ){
		x /= 10;
		mask *= 10;
	}
	
	x = t;
	do{
		int d;
		d = x/mask ;
		printf("%d ", d);
		x = x%mask ;
		mask /= 10;
	}while ( mask > 0 );
	
	printf("\n");
 } 
 
