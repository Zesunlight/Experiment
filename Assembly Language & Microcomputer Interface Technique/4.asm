;----------8255A并行可编程接口芯片实验--------------
CODE    SEGMENT
        ASSUME CS:CODE,DS:CODE,ES:CODE
        ORG 32F0H
PA      EQU 0FFD8H
PB      EQU 0FFD9H
PC      EQU 0FFDAH
PCTL    EQU 0FFDBH

H8:
    MOV AL,81H  ;方式选择，A组方式0，B组方式1，C组第四位输入，高四位输出
    MOV DX,PCTL
    OUT DX,AL
    MOV BX,0FFFH    ;控制LED灯亮灭，为0则亮
    
JUDGE:
    MOV DX,PC
    IN AL,DX    ;读C口
    TEST AL,02H ;判断PC1
    JZ JUDGE    ;为0继续检测
    
    DEC BX
    MOV DX,PA
    MOV AL,BL   ;输出低8位
    OUT DX,AL
    
    MOV DX,PB
    MOV AL,BH   ;输出高8位
    OUT DX,AL
    
    CALL DELAY  ;延时 
    JMP JUDGE
;--------------------------------
DELAY:
    MOV CX,0FFFH
HERE:
    TEST CX,0000H
    LOOP HERE
    RET
;--------------------------------
CODE ENDS
    END H8
