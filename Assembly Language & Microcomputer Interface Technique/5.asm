;----------交通灯综合实验-------------
CODE    SEGMENT
        ASSUME CS:CODE,DS:CODE,ES:CODE
        ORG 3400H
H8:     JMP START
P0      EQU 0FFE0H
P1      EQU 0FFE1H
P2      EQU 0FFE2H
P3      EQU 0FFE3H
PA      EQU 0FFD8H
PB      EQU 0FFD9H
PC      EQU 0FFDAH
PCTL    EQU 0FFDBH
ZXK     EQU 0FFDCH
ZWK     EQU 0FFDDH
LED     DB 0C0H,0F9H,0A4H,0B0H,99H,92H,82H,0F8H,80H,90H
        DB 88H,83H,0C6H,0A1H,86H,8EH,0FFH,0CH,0DEH,0F3H
BUF     DB ?,?,?,?,?,?
PATH    DW 0        ;0东西, 1南北
TIME    DB 10        ;剩余时间
START:  CLI
        CALL WP
        MOV AX,OFFSET INT8259   ;初始化中断向量
        MOV BX,003CH
        MOV [BX],AX
        MOV BX,003EH
        MOV AX,0000H
        MOV [BX],AX

        CALL FOR8253
        CALL FOR8255
        CALL FOR8259
        STI
CON8:   CALL DIS
        JMP CON8
;---------------------------------
INT8259:
        CLI         ;关中断
        MOV CL,TIME
        DEC CL
        MOV BUF,CL
        JNZ L1
        MOV DX,PC
        MOV AL,00H
        OUT DX,AL   ;PC停止计时
        MOV DX,PA
        ADD DX,PATH
        CALL BLINK  ;闪烁
        MOV AL,11111011B   ;红灯 
        OUT DX,AL   
        XOR PATH,1  ;另一方向通行
        MOV DX,PB
        MOV AL,11111101B	;绿灯
        OUT DX,AL   
        MOV CL,10   ;定时器10秒
        MOV DX,PC
        MOV AL,01H  ;PC0=1
        OUT DX,AL   ;开始计时
L1:     MOV TIME,CL
        CALL DIS
        MOV AL,20H
        MOV DX,P0
        OUT DX,AL   ;一般EOI
        POP BX
        MOV BX, OFFSET CON8
        PUSH BX
        STI
        IRET
;----------------------------
BLINK:
        PUSH CX
        MOV CX,05H
NEXT:   MOV AL,11111110B
        OUT DX,AL   ;黄灯亮
        CALL DELAY
        MOV AL,0FFH
        OUT DX,AL   ;黄灯灭
        CALL DELAY_1
        LOOP NEXT
        POP CX
        RET
;-------------------------
FOR8253:     
        MOV DX,0FFE3H
        MOV AL,16H  ;计数器0，只写低，方式3，二进制
        OUT DX,AL

        MOV DX,0FFE0H   ;计数器0初值0004H
        MOV AL,04H
        OUT DX,AL
        
        MOV DX,0FFE3H
        MOV AL,76H  ;计数器1，高低都写，方式3，二进制
        OUT DX,AL

        MOV DX,0FFE1H   ;计数器1初值4B00H
        MOV AL,00H
        OUT DX,AL
        MOV AL,4BH
        OUT DX,AL
        RET
;-------------------------
INIT8255:
        MOV DX,PCTL     ;初始化8255
        MOV AL,89H      ;方式0，AB口输出，C口输入
        OUT DX,AL
        MOV DX,PA
        MOV AL,11111101B
        OUT DX,AL       ;红灯
        MOV DX,PB
        MOV AL,11111011B
        OUT DX,AL       ;绿灯
        MOV TIME,10     ;计时时间10秒
        MOV DX,PC
        MOV AL,01H      ;PC0=1
        OUT DX,AL       ;开始计时
        RET
;----------------------------
FOR8259:MOV AL,13H  ;ICW1，上升沿，单片，要写ICW4
        MOV DX,Port0
        OUT DX,AL
        MOV AL,08H  ;ICW2，IR0的中断向量码为08H
        MOV DX,Port1
        OUT DX,AL
        MOV AL,09H  ;ICW4，一般嵌套，缓冲方式，非自动EOI
        OUT DX,AL
        MOV AL,7FH  ;OCW1，开IR7
        OUT DX,AL
        RET
;-----------------------------
WP:
        MOV BUF,09H  ;初始化显示“9”
        MOV BUF+1,10H
        MOV BUF+2,10H
        MOV BUF+3,10H
        MOV BUF+4,10H
        MOV BUF+5,10H
        RET
;----------------------------
DIS:    
        MOV CL,20H
        MOV BX,OFFSET BUF
DIS1:   MOV AL,[BX]
        PUSH BX
        MOV BX,OFFSET LED
        XLAT
        POP BX
        MOV DX,ZXK
        OUT DX,AL
        MOV AL,CL
        MOV DX,ZWK
        OUT DX,AL
        PUSH CX
        MOV CX,0100H
DELAY:  LOOP $
        POP CX
        CMP CL,01H
        JZ EXIT
        INC BX
        SHR CL,1
        JMP DIS1
EXIT:   MOV AL,00H
        MOV DX,ZWK
        OUT DX,AL
        RET
;----------------------
DELAY_1:
        PUSH CX
        MOV CX,0FFFH
HERE:   TEST CX,0000H
        LOOP HERE
        POP CX
        RET
;------------------------
CODE    ENDS
        END H8
