.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
.CODE
main PROC
	MOV AX, @DATA
	MOV DS, AX
	PUSH BP
	MOV BP, SP
L2:
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
L3:
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
L4:
	MOV AX, [BP-2]
	PUSH AX
	MOV AX, 6
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L6
	MOV AX, 0
	JMP L7
L6:
	MOV AX, 1
L7:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L5
L8:
L9:
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
	JMP L4
L5:
L10:
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
L11:
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
L12:
L13:
	MOV AX, [BP-6]
	PUSH AX
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JG L15
	MOV AX, 0
	JMP L16
L15:
	MOV AX, 1
L16:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L14
L17:
L18:
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
L19:
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
	JMP L13
L14:
L20:
	PUSH AX
	MOV AX, [BP-8]
	CALL print_output
	CALL new_line
	POP AX
L21:
	PUSH AX
	MOV AX, [BP-6]
	CALL print_output
	CALL new_line
	POP AX
L22:
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
L23:
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
L24:
L25:
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
	JE L26
L27:
L28:
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
	JMP L25
L26:
L29:
	PUSH AX
	MOV AX, [BP-8]
	CALL print_output
	CALL new_line
	POP AX
L30:
	PUSH AX
	MOV AX, [BP-6]
	CALL print_output
	CALL new_line
	POP AX
L31:
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L1
L1:
	ADD SP, 8
	POP BP
	MOV AX, 4CH
	INT 21H
main ENDP

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
