;-----------利用学号查学生的数学成绩表--------
TITLE   TABLE       LOOKUP
DATA     SEGMENT
TABLE    DB     81, 78, 90, 64, 85, 76, 93, 82, 57, 80
         DB     73, 62, 87, 77, 74, 86, 95, 91, 82, 71
NUM      DB     8	;查第八个
MATH     DB     ?	;存成绩
DATA     ENDS

STACK1  SEGMENT  PARA  STACK
        DW   20H    DUP(0)
STACK1  ENDS

COSEG    SEGMENT
                 ASSUME  CS:COSEG,DS:DATA,SS:STACK1
START:  		  MOV   AX,DATA  
                MOV    DS,AX       ;送段基址
                MOV    BX,OFFSET  TABLE   ;偏移量
                XOR    AH,AH     ;清零                     
                MOV    AL,NUM          
                DEC    AL      ;从0开始的，所以-1              
                XLAT    ;根据NUM查表
                MOV   MATH ,AL
                MOV   AH,4CH          
                INT      21H
COSEG  ENDS
                END   START
