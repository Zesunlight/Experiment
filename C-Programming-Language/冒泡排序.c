#include<stdio.h>
int main()
{
	int n=1;
	scanf("%d", &n);		//������� 
	int a[n];
	int i=0, j=0, swap=0;
	for ( ; i<n; i++){
		scanf("%d", &a[i]);
	}
	
	for( i=1; i<n; i++){            //ɨ��ı���
		for( j=0; j<n-i; j++){         //һ���бȽϵ�Ԫ�� 
			if( a[j] < a[j+1]){          //������򣬾ͽ��� 
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
		printf("%d ", a[i]);		//�Ӵ�С��� 
	}
	
	return 0;
}
