#include<stdio.h>
int main()
{
	int n=1;
	scanf("%d", &n);		//数组个数 
	int a[n];
	int i=0, j=0, swap=0;
	for ( ; i<n; i++){
		scanf("%d", &a[i]);
	}
	
	for( i=1; i<n; i++){            //扫描的遍数
		for( j=0; j<n-i; j++){         //一遍中比较的元素 
			if( a[j] < a[j+1]){          //如果逆序，就交换 
				a[j] = a[j] + a[j+1] ;
				a[j+1] = a[j] - a[j+1] ;
				a[j] = a[j] - a[j+1] ;
				swap=1;
			}
  		}
  		if( swap=0){
    		break;
  		}
	}

	for ( i=0; i<5; i++){
		printf("%d ", a[i]);		//从大到小输出 
	}
	
	return 0;
}
