#include <stdio.h>
int main ()
{
	//copy input to output
	int c = 0;
	while ((c = getchar()) != EOF)
		putchar(c);
	
	return 0;
}
