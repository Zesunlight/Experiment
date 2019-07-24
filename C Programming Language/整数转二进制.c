#include <stdio.h>
 
int main()
{			
	unsigned int judge = 1u << 31;  //0x80000000
	int number = 0;
	scanf("%d", &number);
	for (; judge; judge >>= 1)
		printf("%d", number & judge ? 1 : 0);
	printf("\n");

	return 0;
}
