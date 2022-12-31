#include <stdio.h>
#define MaxInt 10000 
#define MaxVertexNumber 30

//����ṹ----ͼ 
struct graph{
	int WeightMatrix[MaxVertexNumber][MaxVertexNumber];	//���ڽӾ���洢Ȩ�� 
	int Vertex, Edge;									//�������ͱ��� 
};

void Initialize( struct graph *TG );
void Dijkstra( struct graph *TG, int v, int Previous[], int Distance[]);
void ShowWeight( struct graph *TG);
void ShowPath( struct graph *TG, int v, int i, int Previous[]);

int main()
{
	struct graph TestGraph;							//�����ҵ�ͼ 
	struct graph *TG = &TestGraph;					//ָ���ҵ�ͼ��ָ�� 
	Initialize( TG ); 								//��ʼ���ҵ�ͼ
	ShowWeight( TG);
	
	int v = 0;										//ԭ�� 
	int Previous[MaxVertexNumber] = {-1};			//��¼����v����һ������ 
	int Distance[MaxVertexNumber] = {-1};			//��¼��������������·���ĳ��� 
	//-1��ʾ��Ч 
	
	printf("\nwhich point is the start point?\n");
	printf("please input its number: ");
	scanf("%d", &v);
	
	Dijkstra( TG, v, Previous, Distance);
	printf("the shortest paths between v%d and other points are as follows:\n", v);
	for( int i=0; i<TG->Vertex; i++){
		printf("v%d--->v%d:", v, i);
		if( Distance[i] == MaxInt){
			printf(" not connected!");
		} else{
			printf(" v%d", v);
			ShowPath( TG, v, i, Previous);
			printf("\n\t  the distance is %d", Distance[i]);
		}
		printf("\n");
	}
	
	 
	return 0;
}

void Initialize( struct graph *TG )
{
	printf("please input the number of vertex and edge\n");
	printf("the format is as follows:\n5 10\n");
	scanf("%d %d", &TG->Vertex, &TG->Edge);
	
	printf("\nthe vertexes' name is as follows:\n");	//���������Ĭ��Ϊvi 
	for( int i=0; i<TG->Vertex; i++){
		printf("v%d ", i);
	}
	printf("\n");
	
	for (int i=0; i<TG->Vertex; i++){				//��ʼ���ڽӾ���	 
		for (int j=i; j<TG->Vertex; j++){
			if( i==j )
				TG->WeightMatrix[i][j] = 0;				//�Լ����Լ��ľ�����0 
			else{
				TG->WeightMatrix[i][j] = MaxInt;			//��ͬ����֮��ľ���Ĭ��ΪMaxint 
				TG->WeightMatrix[j][i] = MaxInt;			//����ͼ���ڽӾ����ǶԳƾ���	
			}
		}
	}
	printf("\nplease input the weight between two vertexes\n");
	printf("the format is as follows:i j k\n");
	printf("(that means the weight between vi and vj is k)\n");
	for( int i=0; i<TG->Edge; i++){					//����ÿ���ߵ�Ȩ��,��Edge�� 
		int v1, v2, weight;							//��ʱ�洢������Ϣ 
		scanf("%d %d %d", &v1, &v2, &weight);
		TG->WeightMatrix[v1][v2] = weight;			
		TG->WeightMatrix[v2][v1] = weight;			//����ͼ���ڽӾ����ǶԳƾ���
	}
}

void ShowWeight( struct graph *TG)
{
	printf("\nthe weight-matrix is as follows:\n");
	for( int i=0; i<TG->Vertex; i++){
		printf("\tv%d", i);
	}
	printf("\n");
	for( int j=0; j<TG->Vertex; j++){
		printf("v%d\t", j);
		for ( int k=0; k<TG->Vertex; k++){
			if( TG->WeightMatrix[j][k] != MaxInt)
				printf("%d\t", TG->WeightMatrix[j][k]);
			else
				printf("��\t");
		}
		printf("\n");
	}
}

void Dijkstra( struct graph *TG, int v, int Previous[], int Distance[])
{
	//v0��ԭ�� 
	int Source[TG->Vertex];
	//S����������·�����յ㼯��,��Source[i]=1,��vi����S
	//��v����S�����Ѿ�֪����v��vi�����·��.��ʼʱ��v����S 
	
	for( int i=0; i<TG->Vertex; i++){				//��ʼ��Distance 
		Distance[i] = TG->WeightMatrix[v][i];
	}
	for(int i=0; i<TG->Vertex; i++){				//��ʼ��Source��Previous 
		Source[i] = 0;
		Previous[i] = v;
	}
	Source[v] = 1;
	
	for( int i=0; i<TG->Vertex; i++){
		int min = MaxInt;
		int nextpoint = v;								//�ݴ���v����Ķ��� 
		for( int j=0; j<TG->Vertex; j++){
			if( Source[j] != 1){						//����vj����S�� 
				if( Distance[j] < min){		
					min = Distance[j];				//vj��v����������min 
					nextpoint = j;
				} 
			}
		}
		Source[nextpoint] = 1;			//��v����Ķ���nextpoint����S�� 
		
		for( int k=0; k<TG->Vertex; k++){
			if( Source[k]!=1 && min+TG->WeightMatrix[nextpoint][k]<TG->WeightMatrix[v][k]){
				Previous[k] = nextpoint;
				Distance[k] = min+TG->WeightMatrix[nextpoint][k];		//�������·�� 
			}
		}
	} 
}

void ShowPath( struct graph *TG, int v, int i, int Previous[])
{
	if( Previous[i] == v)
		;
	else{
		ShowPath( TG, v, Previous[i], Previous);
	}
	printf("->v%d", i);
}


