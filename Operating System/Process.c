#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Process.h"

int main()
{
	freopen("input.txt", "r", stdin);
	
	//initialization
	init = (PCB*)malloc(sizeof(PCB));
	init->Parent = NULL;
	init->Parent = NULL;
	init->PID = 0;
	strcpy(init->PName, "init");
	init->Priority = 0;
	init->Resource = -1; //occupied none
	init->Amount = 0;
	init->Status = 1;   //running
	printf("init\n");
	
	for (int i = 0; i < 3; i++) {
		ReadyList[i] = (List*)malloc(sizeof(List));
		ReadyList[i]->current = NULL;
		ReadyList[i]->next = NULL;
		BlockedList[i] = (List*)malloc(sizeof(List));
		BlockedList[i]->current = NULL;
		BlockedList[i]->next = NULL;
	}
	running = NULL;
//	char spare = '\0';
	
	//decode the order
	while (scanf("%s", order) != EOF) {
		if (strcmp(order, "cr") == 0) {
			count++;
			now = Create();
			Insert(now, ReadyList[priority]);
		} else if (strcmp(order, "req") == 0) {
			Request();
		} else if (strcmp(order, "rel") == 0) {
			Release();
		} else if (strcmp(order, "to") == 0) {
			TimeOut();
		} else if (strcmp(order, "de") == 0) {
			Destroy();
		} else if (strcmp(order, "ki") == 0) {
			KillTree();
		} else {
			printf("Wrong Instruction!\n");
		}
		
		//output running process at present
		//the first ready process should have a chance
		running = ReadyList[1]->next->current;
		running->Status = 1;    //change form ready to running
		printf("%s\n", running->PName);
	}
	
	return 0;
}

PCB* Create() {
	scanf("%s", name);
	scanf("%d", &priority);
	PCB* newly = (PCB*)malloc(sizeof(PCB));
	strcpy(newly->PName, name);
	newly->Priority = priority;
	newly->Parent = init;
	newly->Children = NULL;
	newly->PID = count;
	newly->Resource = 0;
	newly->Amount = 0;
	return newly;
}
void Destroy() {
	scanf("%s", name);
	//find the process that need to be killed
	temp = ReadyList[1]->next;
	List* former = temp;
	int fail = 0;
	while (strcmp(temp->current->PName, name) != 0) {
		former = temp;
		temp = temp->next;
		if (temp == NULL) {
			fail = 10;   //not find it in ReadyList
			break;
		}
	}
	if (fail == 10) {
		temp = BlockedList[1]->next;
		while (strcmp(temp->current->PName, name) != 0) {
			former = temp;
			temp = temp->next;
			if (temp == NULL) {
				fail = 11;   //not find it in BlockList
				break;
			}
		}
	}
	
	//kill it
	if (fail == 11)
		printf("Process %s does not exist!\n", name);
 	else {
 		RCB[temp->current->Resource] += temp->current->Amount;
		if (temp->current->Children != NULL)
			temp->current->Children->Parent = temp->current->Parent;

		temp = former->next;
		former->next = temp->next;
		free(temp);
		
		//perhaps the blocked process can be satisfied
		PCB* blocked = BlockedList[1]->next->current;
		if (blocked->Amount <= RCB[blocked->Resource]) {
			Insert(blocked, ReadyList[blocked->Priority]);
			RCB[blocked->Resource] -= blocked->Amount;  //occupied resources
			blocked->Status = 0;    //change from blocked to ready

			//delete it form BlockList
			temp = BlockedList[1]->next;
			BlockedList[1]->next = temp->next;
			free(temp);   //get off from BlockedList
		}
	}
	
}
void KillTree() {
	RCB[running->Resource] += running->Amount;
	PCB* check = running->Children;
	PCB* assist = NULL;
	
	temp = ReadyList[running->Priority]->next;
	ReadyList[running->Priority]->next = temp->next;
	free(temp);
	free(running);
	
	while ( check != NULL) {
		assist = check->Children;
		free(check);
		check = assist;
	}
}
void Request() {
	int foreheadResource = running->Resource;
	int foreheadAmount = running->Amount;
	scanf("%s", name);
	scanf("%d", &running->Amount); //amount of needed resource
	running->Resource = (int)(name[1] - '0' - 1);
	if (running->Amount > RCB[running->Resource]) {
		//not enough resource, turn to blocked status
		//fetch already occupied resource
		RCB[foreheadResource] += foreheadAmount;
		Insert(running, BlockedList[running->Priority]);
		
		temp = ReadyList[running->Priority]->next;
		ReadyList[running->Priority]->next = temp->next;
		free(temp);
	} else
		RCB[running->Resource] -= running->Amount;
}
void Release() {
	RCB[running->Resource] += running->Amount;
	running->Amount = 0;
	//if the first blocked process's needs can be satisfied, let it go
	//as for the running process, add it to the end of ReadyList
	PCB* blocked = BlockedList[running->Priority]->next->current;
	if (blocked->Amount <= RCB[blocked->Resource]) {
		Insert(blocked, ReadyList[blocked->Priority]);
		RCB[blocked->Resource] -= blocked->Amount;  //occupied resources
		blocked->Status = 0;    //change from blocked to ready

		//delete it form BlockList
		temp = BlockedList[1]->next;
		BlockedList[1]->next = temp->next;
		free(temp);   //get off from BlockedList
	}
}
void TimeOut() {
	//change from running to ready
	//the same as requiring resource but failed
	Insert(running, ReadyList[running->Priority]);
	temp = ReadyList[running->Priority]->next;
	ReadyList[running->Priority]->next = temp->next;
	free(temp);
}
void Insert(PCB* where, List* there) {
	List* tail = there;
	while (tail->next != NULL)  //find the end of the list
		tail = tail->next;
	temp = (List*)malloc(sizeof(List));
	tail->next = temp;
	temp->current = where;
	temp->next = NULL;
}
