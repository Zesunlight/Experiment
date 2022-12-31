#include <stdio.h>
#define MaxInt 10000 
#define MaxVertexNumber 30

//定义结构----图 
struct graph{
	int WeightMatrix[MaxVertexNumber][MaxVertexNumber];	//用邻接矩阵存储权重 
	int Vertex, Edge;									//顶点数和边数 
};

void Initialize( struct graph *TG );
void Dijkstra( struct graph *TG, int v, int Previous[], int Distance[]);
void ShowWeight( struct graph *TG);
void ShowPath( struct graph *TG, int v, int i, int Previous[]);

int main()
{
	struct graph TestGraph;							//创建我的图 
	struct graph *TG = &TestGraph;					//指向我的图的指针 
	Initialize( TG ); 								//初始化我的图
	ShowWeight( TG);
	
	int v = 0;										//原点 
	int Previous[MaxVertexNumber] = {-1};			//记录到达v的上一个顶点 
	int Distance[MaxVertexNumber] = {-1};			//记录到各个顶点的最短路径的长度 
	//-1表示无效 
	
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
	
	printf("\nthe vertexes' name is as follows:\n");	//顶点的名字默认为vi 
	for( int i=0; i<TG->Vertex; i++){
		printf("v%d ", i);
	}
	printf("\n");
	
	for (int i=0; i<TG->Vertex; i++){				//初始化邻接矩阵	 
		for (int j=i; j<TG->Vertex; j++){
			if( i==j )
				TG->WeightMatrix[i][j] = 0;				//自己到自己的距离是0 
			else{
				TG->WeightMatrix[i][j] = MaxInt;			//不同顶点之间的距离默认为Maxint 
				TG->WeightMatrix[j][i] = MaxInt;			//无向图的邻接矩阵是对称矩阵	
			}
		}
	}
	printf("\nplease input the weight between two vertexes\n");
	printf("the format is as follows:i j k\n");
	printf("(that means the weight between vi and vj is k)\n");
	for( int i=0; i<TG->Edge; i++){					//输入每条边的权重,输Edge次 
		int v1, v2, weight;							//暂时存储输入信息 
		scanf("%d %d %d", &v1, &v2, &weight);
		TG->WeightMatrix[v1][v2] = weight;			
		TG->WeightMatrix[v2][v1] = weight;			//无向图的邻接矩阵是对称矩阵
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
				printf("∞\t");
		}
		printf("\n");
	}
}

void Dijkstra( struct graph *TG, int v, int Previous[], int Distance[])
{
	//v0是原点 
	int Source[TG->Vertex];
	//S是已求得最短路径的终点集合,若Source[i]=1,则vi属于S
	//若v属于S，即已经知道了v到vi的最短路径.初始时，v属于S 
	
	for( int i=0; i<TG->Vertex; i++){				//初始化Distance 
		Distance[i] = TG->WeightMatrix[v][i];
	}
	for(int i=0; i<TG->Vertex; i++){				//初始化Source和Previous 
		Source[i] = 0;
		Previous[i] = v;
	}
	Source[v] = 1;
	
	for( int i=0; i<TG->Vertex; i++){
		int min = MaxInt;
		int nextpoint = v;								//暂存离v最近的顶点 
		for( int j=0; j<TG->Vertex; j++){
			if( Source[j] != 1){						//顶点vj不在S中 
				if( Distance[j] < min){		
					min = Distance[j];				//vj离v更近，更新min 
					nextpoint = j;
				} 
			}
		}
		Source[nextpoint] = 1;			//离v最近的顶点nextpoint加入S集 
		
		for( int k=0; k<TG->Vertex; k++){
			if( Source[k]!=1 && min+TG->WeightMatrix[nextpoint][k]<TG->WeightMatrix[v][k]){
				Previous[k] = nextpoint;
				Distance[k] = min+TG->WeightMatrix[nextpoint][k];		//更新最短路径 
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


