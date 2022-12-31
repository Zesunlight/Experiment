#include <stdio.h>
unsigned int power(unsigned int x, unsigned int n);
int main ()
{
	unsigned int x = 1, n = 1;
	while (scanf("%u%u", &x, &n)) {
		printf("%u\n", power(x, n));
	}
	
	return 0;
}

unsigned int power(unsigned int x, unsigned int n)
{
	if (n == 0)
		return 1;
	if (n == 1)
		return x;
		
	unsigned int temp = power(x, n / 2);
	unsigned int result = temp * temp;
	if (n % 2 == 1)
		result *= x;
	return result;
}
