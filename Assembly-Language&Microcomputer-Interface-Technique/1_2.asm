;---------无符号数排序-----------
	DATA SEGMENT
    ARY DB 17,5,40,0,67,12,34,78,32,10
    MAX DB ?
DATA ENDS
STACK1 SEGMENT PARA STACK
    DW 20H DUP(0)
STACK1 ENDS
CODE SEGMENT
    ASSUME CS:CODE,DS:DATA,SS:STACK1
BEGIN:
    MOV AX,DATA
    MOV DS,AX	;送段基址
    MOV SI,OFFSET ARY	;取偏移
    MOV CX,9    ;一共9个数据
    MOV AL,[SI] ;取第一个数据到AL
NEXT:                    
    INC SI	;下一个数据
    CMP AL, [SI]
    JG LARGE		;AL大的话，转LARGE
    MOV AL, [SI]    ;大数移到AL中
LARGE:               
    MOV MAX, AL                  
    LOOP NEXT	;先-1，再转
    
    MOV AH, 4CH
    INT 21H     
CODE ENDS
    END BEGIN
