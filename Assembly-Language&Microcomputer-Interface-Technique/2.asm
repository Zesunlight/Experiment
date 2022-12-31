;-------------------8259中断实验-------------------
CODE    SEGMENT
        ASSUME CS:CODE,DS:CODE,ES:CODE
        ORG 3400H   ;起始地址，位于用户区
H8:     JMP P8259
ZXK     EQU 0FFDCH  ;字形口地址
ZWK     EQU 0FFDDH  ;字位口地址
LED     DB 0C0H,0F9H,0A4H,0B0H,99H,92H,82H,0F8H,80H,90H
        DB 88H,83H,0C6H,0A1H,86H,8EH,0FFH,0CH,0DEH,0F3H
        ;0~F、P.、左上直角、右下直角的形状代码，DPgfedcba，为0则亮
BUF     DB ?,?,?,?,?,?  ;指定6片数码管
PORT0   EQU 0FFE0H  ;8259的偶地址
PORT1   EQU 0FFE1H  ;8259的奇地址
P8259:  CLI ;关中断，避免其他中断的影响
        CALL WP        ;初始化显示“P.”
        MOV AX,OFFSET INT8259
        MOV BX,003CH    ;IR7的中断向量码为0FH，0FH*4=3CH
        MOV [BX],AX
        MOV BX,003EH
        MOV AX,0000H    ;中断向量表基址为0000H
        MOV [BX],AX
        MOV AX,OFFSET INT8259A
        MOV BX,0038H    ;IR6的中断向量码为0EH，0EH*4=38H
        MOV [BX],AX
        MOV BX,003AH
        MOV AX,0000H
        MOV [BX],AX
        CALL FOR8259    ;初始化8259
        MOV SI,0000H
        STI ;开中断
CON8:   CALL DIS
        JMP CON8
;------------------------------------
INT8259:CLI
        MOV BX,OFFSET BUF
        MOV BYTE PTR [BX],07H
        
        MOV CX,0003H
XXX59:  PUSH CX
        CALL DIS
        POP CX
        LOOP XXX59
        
        MOV AL,20H  ;OCW2，一般EOI命令
        MOV DX,PORT0
        OUT DX,AL
        STI
        IRET
;------------------------------------
INT8259A:
        CLI
        MOV BX,OFFSET BUF
        MOV BYTE PTR [BX],06H
        
        MOV CX,0003H
XX59A:  PUSH CX
        CALL DIS
        POP CX
        LOOP XX59A
        
        MOV AL,20H  ;OCW2，一般EOI命令
        MOV DX,PORT0
        OUT DX,AL
        STI
        IRET
;==============================
FOR8259:MOV AL,13H  ;ICW1，上升沿，单片，要写ICW4
        MOV DX,PORT0
        OUT DX,AL
        MOV AL,08H  ;ICW2，IR0的中断向量码为08H
        MOV DX,PORT1
        OUT DX,AL
        MOV AL,09H  ;ICW4，一般嵌套，缓冲方式，非自动EOI
        OUT DX,AL
        MOV AL,3FH  ;OCW1，屏蔽IR0~IR5
        OUT DX,AL
        RET
;---------------------------
WP:     MOV BUF,11H     ;初始化显示“P.”
        MOV BUF+1,10H   ;不亮
        MOV BUF+2,10H
        MOV BUF+3,10H
        MOV BUF+4,10H
        MOV BUF+5,10H
        RET
;--------------------------------
DIS:    MOV CL,20H  ;字位码指向左侧第一个数码管
        MOV BX,OFFSET BUF
DIS1:   MOV AL,[BX] ;取第一个需要显示的字符
        PUSH BX ;保存BX
        MOV BX,OFFSET LED
        XLAT    ;查到相应的字形码到AL
        POP BX  ;恢复BX
        MOV DX,ZXK
        OUT DX,AL   ;输出字形码
        MOV AL,CL   
        MOV DX,ZWK
        OUT DX,AL   ;输出到数码管
        PUSH CX
        MOV CX,0100H
DELAY:  LOOP $  ;延时
        POP CX
        CMP CL,01H  ;是否显示到最右侧的数码管
        JZ EXIT
        INC BX
        SHR CL,1
        JMP DIS1    ;显示下一个
EXIT:   MOV AL,00H
        MOV DX,ZWK
        OUT DX,AL   ;不在数码管上显示了
        RET
;--------------------------
CODE    ENDS
        END H8
