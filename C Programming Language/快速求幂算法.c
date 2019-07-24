#include <stdio.h>
unsigned long int quick_pow(int x, int n);
int main()
{
    /*
    快速求幂，分治的思想
    看指数的二进制形式
    利用已经计算好的结果
    */
    int x = 1, n = 1;
    while (scanf("%d%d", &x, &n) != EOF)
        printf("%lu\n", quick_pow(x, n));
<<<<<<< HEAD

=======
>>>>>>> origin/master
    return 0;
}
unsigned long int quick_pow(int x, int n)
{
    unsigned long int result = 1;
    while (n > 0) {
        if (n & 1)      //n和1做与运算，等价于(n % 2) == 1
            result *= x;
        x = x * x;
        n = n >> 1;     //n右移一位，等价于n = n / 2
    }
    return result;
}
