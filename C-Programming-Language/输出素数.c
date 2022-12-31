#include<stdio.h>
#include<math.h> 
int isprime(int a);
int main(){
	int a;
	int i;
	for ( a=2; a<=100; a++){
//		int b = sqrt(a);
//		int m=1;

//		for ( i=2; i<=b; i++){
//			if (a%i==0){
//				m=0;
//				break;
//			}
//		}
		if ( isprime(a) ){
			printf("%d ",a);
		}
	}
	printf("\n");
	return 0;
}

int isprime(int a)
{
	int b = sqrt(a);
	int m=1;
	int i;
	if( a==1 || (a%2==0 && a!=2) )
		m=0;
	for ( i=3; i<=b; i+=2){
		if (a%i==0){
			m=0;
			break;
		}
	}
	return m;
}
