;-------------8253时钟中断计时实验---------------
CODE    SEGMENT
        ASSUME CS:CODE,DS:CODE,ES:CODE
        ORG 3490H
H8:     JMP P8259
ZXK     EQU 0FFDCH  ;字形口
ZWK     EQU 0FFDDH  ;字位口
LED     DB 0C0H,0F9H,0A4H,0B0H,99H,92H,82H,0F8H,80H,90H
        DB 88H,83H,0C6H,0A1H,86H,8EH,0FFH,0CH,0DEH,0F3H
BUF     DB ?,?,?,?,?,?  ;缓冲区
PORT0   EQU 0FFE0H
PORT1   EQU 0FFE1H
P8259:  CLI
        CALL WP        ;初始化显示“P.”
        
        MOV AX,OFFSET IR7_TICK
        MOV BX,003CH
        MOV [BX],AX
        MOV BX,003EH
        MOV AX,0000H
        MOV [BX],AX

        CALL FOR8253
        CALL FOR8259      
        
        STI
CON8:   CALL DIS
        JMP CON8
;------------------------------------
IR7_TICK:
        CLI      
        ;缓冲区存“good”
        MOV BUF,09H
        MOV BUF+1,00H
        MOV BUF+2,00H
        MOV BUF+3,0DH

        MOV CX,0050H
XXX59:  PUSH CX
        CALL DIS    ;显示
        POP CX
        LOOP XXX59
        POP CX
        MOV CX, OFFSET CON8
        PUSH CX
        
        MOV AL,20H  ;一般EOI
        MOV DX,PORT0
        OUT DX,AL
        STI
        IRET
;==============================
FOR8259:MOV AL,13H  ;上升沿，单片，写
        MOV DX,Port0
        OUT DX,AL
        MOV AL,08H  ;IR0中断号为08H
        MOV DX,Port1
        OUT DX,AL
        MOV AL,09H  ;一般嵌套，缓冲方式，非自动EOI
        OUT DX,AL
        MOV AL,7FH  ;开放IR7
        OUT DX,AL
        RET
;==============================
FOR8253:MOV DX,0FFE3H
        MOV AL,11H  ;计数器0，低8位，方式0，BCD
        OUT DX,AL
        MOV DX,0FFE0H
        MOV AL,19H  ;计数初值，因为与T7相连
        OUT DX,AL
        RET
;---------------------------
WP:     MOV BUF,11H
        MOV BUF+1,10H
        MOV BUF+2,10H
        MOV BUF+3,10H
        MOV BUF+4,10H
        MOV BUF+5,10H
        RET
;--------------------------
DIS:    MOV CL,20H
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
;--------------------------
CODE    ENDS
        END H8
