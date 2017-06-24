typedef struct ProcessControlBlock{
	int PID;
	char PName[10];
	int Resource;	//which resource you've occupied
	int Amount;     //how many (resource)
	int Status;		//0~ready 1~running 2~blocked
	struct ProcessControlBlock* Parent;
	struct ProcessControlBlock* Children;
	int Priority;   //0, 1, 2 (Init, User, System)
}PCB;
PCB *init, *now, *running;
char name[] = "restlessness";
int priority = 0;

typedef struct queue{
	PCB* current;
	struct queue* next;
}List;
List* temp;
//for every List, its first node's PCB will be NULL
List* ReadyList[3];
List* BlockedList[3];

PCB* Create();
void Destroy();
void KillTree();

int RCB[4] = {1, 2, 3, 4};  //four resources and its value means status

void Request();
void Release();

char order[] = "unknown";
int count = 0; //just for PID

void Insert(PCB* where, List* there);
void TimeOut();
