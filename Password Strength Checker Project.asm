.MODEL SMALL
.STACK 100H
.DATA
string1 db "Enter Password: $"
string2 db "Weak Password$"
string3 db "Moderate Password$"
string4 db "Strong Password$"
name1 DB 9 DUP(?)
.CODE
    MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ;code here
    LEA dx,string1
    mov ah,9
    int 21h
   
    LEA SI, name1
MOV AH,1
MOV CX,9

input_loop:
   INT 21H
   MOV [SI],AL
   INC SI
LOOP input_loop
MOV AH, 2
MOV DL, 0AH
INT 21H
MOV DL, 0DH
INT 21H

 
MOV AH,0
MOV AL,0
MOV BH,0
MOV BL,0
MOV CX,9
MOV SI,0

output_loop:
   
    MOV DL, name1[SI]
    CMP DL, 61h
    Jl cap
    CMP DL, 7Ah
    JG spe
    mov ah,1
    JMP Exit
    cap:
      CMP DL, 41h
      JL  num
      CMP DL, 5Ah
      JG spe
      mov al,1
      JMP EXIT
    num:
      CMP DL, 30h
      JL spe
      CMP DL, 39h
      JG spe
      mov bh,1
      JMP EXIT
    spe:
      mov bl,1
     
    Exit:
      INC SI
      LOOP output_loop

ADD BL,AH
ADD BL,AL
ADD BL,BH
CMP BL,3
JL weak
JG strong
LEA DX,string3
    MOV AH,9
    INT 21H
    JMP print
    weak:
       LEA DX,string2
       MOV AH,9
       INT 21H
       JMP print
    strong:
       LEA DX,string4
       MOV AH,9
       INT 21H
       JMP print
   
    print:


    MAIN ENDP
END MAIN



