;-----------����ѧ�Ų�ѧ������ѧ�ɼ���--------
TITLE   TABLE       LOOKUP
DATA     SEGMENT
TABLE    DB     81, 78, 90, 64, 85, 76, 93, 82, 57, 80
         DB     73, 62, 87, 77, 74, 86, 95, 91, 82, 71
NUM      DB     8	;��ڰ˸�
MATH     DB     ?	;��ɼ�
DATA     ENDS

STACK1  SEGMENT  PARA  STACK
        DW   20H    DUP(0)
STACK1  ENDS

COSEG    SEGMENT
                 ASSUME  CS:COSEG,DS:DATA,SS:STACK1
START:  		  MOV   AX,DATA  
                MOV    DS,AX       ;�Ͷλ�ַ
                MOV    BX,OFFSET  TABLE   ;ƫ����
                XOR    AH,AH     ;����                     
                MOV    AL,NUM          
                DEC    AL      ;��0��ʼ�ģ�����-1              
                XLAT    ;����NUM���
                MOV   MATH ,AL
                MOV   AH,4CH          
                INT      21H
COSEG  ENDS
                END   START
