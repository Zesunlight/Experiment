#include <stdio.h>

int main()
{
	int a = 0, b = 0, c = 0;
	while (scanf("%d", &c) != EOF) {
		if (c >= a) {
			int temp = a;
			a = c;
			b = temp;
		} else if (c >= b)
			b = c;
	}
	printf("1st: %d\n2nd: %d\n", a, b);
	
	return 0;
}

