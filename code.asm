.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
	a DW 1 DUP (0000H)
	b DW 1 DUP (0000H)
	c DW 1 DUP (0000H)
MAIN PROC
	MOV AX, @DATA
	MOV DS, AX
	PUSH BP
	MOV BP, SP
L1:
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
L2:
	MOV AX, 7
	PUSH AX
	POP AX
	PUSH AX
	MOV AX, 20
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	POP AX
	CWD
	IMUL BX
	PUSH AX
	MOV AX, 5
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	POP AX
	CWD
	IDIV BX
	PUSH AX
	PUSH AX
	MOV [BP-2], AX
	POP AX
L3:
L4:
	SUB SP, 2
	SUB SP, 8
L5:
	MOV AX, 100
	PUSH AX
	POP AX
	PUSH AX
	MOV AX, 34
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	POP AX
	ADD AX, BX
	PUSH AX
	MOV AX, 69
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	POP AX
	ADD AX, BX
	PUSH AX
	MOV AX, 53
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	POP AX
	SUB AX, BX
	PUSH AX
	PUSH AX
	MOV [BP-8], AX
	POP AX
L6:
	PUSH AX
	MOV AX, [BP-8]
	CALL print_output
	CALL new_line
	POP AX
L7:
	MOV AX, 33
	PUSH AX
	POP AX
	PUSH AX
	CMP AX, 0
	JE L8
	MOV AX, 0
	JMP L9
L8:
	MOV AX, 1
L9:
	PUSH AX
	PUSH AX
	MOV [BP-8], AX
	POP AX
L10:
	PUSH AX
	MOV AX, [BP-8]
	CALL print_output
	CALL new_line
	POP AX
L11:
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	CMP AX, 0
	JE L12
	MOV AX, 0
	JMP L13
L12:
	MOV AX, 1
L13:
	PUSH AX
	PUSH AX
	MOV [BP-8], AX
	POP AX
L14:
	PUSH AX
	MOV AX, [BP-8]
	CALL print_output
	CALL new_line
	POP AX
L15:
	PUSH AX
	MOV AX, [BP-2]
	CALL print_output
	CALL new_line
	POP AX
L16:
	MOV AX, 420
	PUSH AX
	POP AX
	PUSH AX
	MOV AX, 55
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	POP AX
	CWD
	IDIV BX
	MOV AX, DX
	PUSH AX
	PUSH AX
	MOV [BP-6], AX
	POP AX
L17:
	PUSH AX
	MOV AX, [BP-6]
	CALL print_output
	CALL new_line
	POP AX
L18:
	MOV AX, 20
	PUSH AX
	POP AX
	PUSH AX
	MOV AX, 300
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L19
	MOV AX, 0
	JMP L20
L19:
	MOV AX, 1
L20:
	PUSH AX
	PUSH AX
	MOV [BP-4], AX
	POP AX
L21:
	PUSH AX
	MOV AX, [BP-4]
	CALL print_output
	CALL new_line
	POP AX
L22:
	MOV AX, 20
	PUSH AX
	POP AX
	PUSH AX
	MOV AX, 300
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JGE L23
	MOV AX, 0
	JMP L24
L23:
	MOV AX, 1
L24:
	PUSH AX
	PUSH AX
	MOV [BP-4], AX
	POP AX
L25:
	PUSH AX
	MOV AX, [BP-4]
	CALL print_output
	CALL new_line
	POP AX
	ADD SP, 16
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
