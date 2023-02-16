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
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	POP AX
	CMP AX, 0
	JE L17
	CMP BX, 0
	JE L17
	MOV AX, 1
	JMP L18
L17:
	MOV AX, 0
L18:
	PUSH AX
	PUSH AX
	MOV [BP-8], AX
	POP AX
L19:
	PUSH AX
	MOV AX, [BP-8]
	CALL print_output
	CALL new_line
	POP AX
L20:
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	MOV AX, 1
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	POP AX
	CMP AX, 0
	JE L21
	CMP BX, 0
	JE L21
	MOV AX, 1
	JMP L22
L21:
	MOV AX, 0
L22:
	PUSH AX
	PUSH AX
	MOV [BP-8], AX
	POP AX
L23:
	PUSH AX
	MOV AX, [BP-8]
	CALL print_output
	CALL new_line
	POP AX
L24:
	MOV AX, 1
	PUSH AX
	POP AX
	PUSH AX
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	POP AX
	CMP AX, 0
	JE L25
	CMP BX, 0
	JE L25
	MOV AX, 1
	JMP L26
L25:
	MOV AX, 0
L26:
	PUSH AX
	PUSH AX
	MOV [BP-8], AX
	POP AX
L27:
	PUSH AX
	MOV AX, [BP-8]
	CALL print_output
	CALL new_line
	POP AX
L28:
	MOV AX, 1
	PUSH AX
	POP AX
	PUSH AX
	MOV AX, 1
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	POP AX
	CMP AX, 0
	JE L29
	CMP BX, 0
	JE L29
	MOV AX, 1
	JMP L30
L29:
	MOV AX, 0
L30:
	PUSH AX
	PUSH AX
	MOV [BP-8], AX
	POP AX
L31:
	PUSH AX
	MOV AX, [BP-8]
	CALL print_output
	CALL new_line
	POP AX
L32:
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
L33:
	PUSH AX
	MOV AX, [BP-6]
	CALL print_output
	CALL new_line
	POP AX
L34:
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
	JL L35
	MOV AX, 0
	JMP L36
L35:
	MOV AX, 1
L36:
	PUSH AX
	PUSH AX
	MOV [BP-4], AX
	POP AX
L37:
	PUSH AX
	MOV AX, [BP-4]
	CALL print_output
	CALL new_line
	POP AX
L38:
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
	JGE L39
	MOV AX, 0
	JMP L40
L39:
	MOV AX, 1
L40:
	PUSH AX
	PUSH AX
	MOV [BP-4], AX
	POP AX
L41:
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
