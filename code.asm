.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
MAIN PROC
	MOV AX, @DATA
	MOV DS, AX
	PUSH BP
	MOV BP, SP
L1:
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
L2:
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-2], AX
	PUSH AX
	POP AX
L3:
	MOV AX, [BP-2]
	PUSH AX
	MOV AX, 6
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L5
	MOV AX, 0
	JMP L6
L5:
	MOV AX, 1
L6:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L4
L7:
L8:
	PUSH AX
	MOV AX, [BP-2]
	CALL print_output
	CALL new_line
	POP AX
	MOV AX, [BP-2]
	MOV CX, [BP-2]
	INC CX
	MOV [BP-2], CX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L3
L4:
L9:
	MOV AX, 4
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-6], AX
	PUSH AX
	POP AX
L10:
	MOV AX, 6
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-8], AX
	PUSH AX
	POP AX
L11:
L12:
	MOV AX, [BP-6]
	PUSH AX
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JG L14
	MOV AX, 0
	JMP L15
L14:
	MOV AX, 1
L15:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L13
L16:
L17:
	MOV AX, [BP-8]
	PUSH AX
	MOV AX, 3
	PUSH AX
	POP BX
	POP AX
	ADD AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-8], AX
	PUSH AX
	POP AX
L18:
	MOV AX, [BP-6]
	MOV CX, [BP-6]
	DEC CX
	MOV [BP-6], CX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L12
L13:
L19:
	PUSH AX
	MOV AX, [BP-8]
	CALL print_output
	CALL new_line
	POP AX
L20:
	PUSH AX
	MOV AX, [BP-6]
	CALL print_output
	CALL new_line
	POP AX
L21:
	MOV AX, 4
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-6], AX
	PUSH AX
	POP AX
L22:
	MOV AX, 6
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-8], AX
	PUSH AX
	POP AX
L23:
L24:
	MOV AX, [BP-6]
	MOV CX, [BP-6]
	DEC CX
	MOV [BP-6], CX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L25
L26:
L27:
	MOV AX, [BP-8]
	PUSH AX
	MOV AX, 3
	PUSH AX
	POP BX
	POP AX
	ADD AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-8], AX
	PUSH AX
	POP AX
	JMP L24
L25:
L28:
	PUSH AX
	MOV AX, [BP-8]
	CALL print_output
	CALL new_line
	POP AX
L29:
	PUSH AX
	MOV AX, [BP-6]
	CALL print_output
	CALL new_line
	POP AX
L30:
	ADD SP, 8
	MOV SP, BP
	POP BP
	MOV AX, 4CH
	INT 21H
MAIN ENDP

print_output proc  ;print what is in ax
    push ax
    push bx
    push cx
    push dx
    push si
    lea si,number
    mov bx,10
    add si,4
    cmp ax,0
    jnge negate
    print:
    xor dx,dx
    div bx
    mov [si],dl
    add [si],'0'
    dec si
    cmp ax,0
    jne print
    inc si
    lea dx,si
    mov ah,9
    int 21h
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    negate:
    push ax
    mov ah,2
    mov dl,'-'
    int 21h
    pop ax
    neg ax
    jmp print
print_output endp

new_line proc
    push ax
    push dx
    mov ah,2
    mov dl,cr
    int 21h
    mov ah,2
    mov dl,lf
    int 21h
    pop dx
    pop ax
    ret
new_line endp

END MAIN
