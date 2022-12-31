;---------将两个给定的二进制数(8位和16位)转换为ASCII码字符串-------
DATA SEGMENT
    BIN1 DB 35H
    BIN2 DW 0AB4H
    CUNT DB 8, 16
    ASCII DB 20H DUP(?)
    ADR DW 3 DUP(0);address 
DATA ENDS

STACK SEGMENT
    DW 20H DUP(?)
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA,SS:STACK
START:
    MOV AX,DATA
    MOV DS,AX
    
    MOV ADR, OFFSET BIN1
    MOV ADR+2, OFFSET CUNT
    MOV ADR+4, OFFSET ASCII
    MOV BX, OFFSET ADR
    MOV DI, [BX]
    MOV DH, [DI];transfered number
    CALL BINASC
    
    MOV ADR, OFFSET BIN2
    MOV ADR+2, OFFSET CUNT+1
    MOV ADR+4, OFFSET ASCII+8
    MOV BX, OFFSET ADR;address of ADR
    MOV DI, [BX]
    MOV DX, [DI];transfered number
    CALL BINASC
    
    MOV AH,4CH
    INT 21H
    
BINASC PROC
    MOV DI, [BX+2]
    MOV CL, [DI];digit length
    XOR CH, CH;set zero as for loop
    MOV DI, [BX+4];put ascii
LOP:
    ROL DX, 1;the highest moves to the lowest
    MOV AL, DL
    AND AL, 1;store the one
    ADD AL, 30H;calculate ascii
    MOV [DI], AL;store ascii
    INC DI
    LOOP LOP
    RET
BINASC ENDP
    
CODE ENDS
    END START
