#include <stdio.h>
#include <math.h> 
int main ()  								
{	
	int n=1;
	scanf("%d", &n);
	
	printf("%d=", n);
	for ( int i=2; n != 1; i++){
		if ( n%i==0 ){
			printf("%d", i);
			n = n/i;
			i--;
			
			if ( n != 1)
				printf("x");	
		}
	}
	
	return 0; 
}

