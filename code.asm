.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
	a DW 1 DUP (0000H)
	b DW 1 DUP (0000H)
	c DW 1 DUP (0000H)
	go DW 4 DUP (0000H)
MAIN PROC
	MOV AX, @DATA
	MOV DS, AX
	PUSH BP
	MOV BP, SP
L1:
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
	SUB SP, 10
L2:
	MOV AX, 7
	PUSH AX
	MOV AX, 20
	PUSH AX
	POP BX
	POP AX
	CWD
	IMUL BX
	PUSH AX
	MOV AX, 5
	PUSH AX
	POP BX
	POP AX
	CWD
	IDIV BX
	PUSH AX
	POP AX
	MOV [BP-2], AX
L3:
	MOV AX, 101
	PUSH AX
	POP AX
	MOV a, AX
L4:
	MOV AX, 44
	PUSH AX
	POP AX
	PUSH SI
	PUSH AX
	MOV AX, 1
	PUSH AX
	POP AX
	LEA SI, go
	ADD SI, AX
	ADD SI, AX
	POP AX
	MOV [SI], AX
	POP SI
L5:
L6:
	MOV AX, 444
	PUSH AX
	POP AX
	PUSH SI
	PUSH AX
	MOV AX, 3
	PUSH AX
	POP AX
	LEA SI, go
	ADD SI, AX
	ADD SI, AX
	POP AX
	MOV [SI], AX
	POP SI
L7:
	MOV AX, 292
	PUSH AX
	POP AX
	MOV b, AX
L8:
	MOV AX, 6996
	PUSH AX
	POP AX
	PUSH SI
	PUSH AX
	MOV AX, 1
	PUSH AX
	POP AX
	MOV SI, -8
	SUB SI, AX
	SUB SI, AX
	POP AX
	MOV [BP+SI], AX
	POP SI
L9:
	SUB SP, 2
	SUB SP, 8
L10:
	MOV AX, 100
	PUSH AX
	MOV AX, 34
	PUSH AX
	POP BX
	POP AX
	ADD AX, BX
	PUSH AX
	MOV AX, 69
	PUSH AX
	POP BX
	POP AX
	ADD AX, BX
	PUSH AX
	MOV AX, 53
	PUSH AX
	POP BX
	POP AX
	SUB AX, BX
	PUSH AX
	POP AX
	MOV [BP-18], AX
L11:
	PUSH AX
	MOV AX, [BP-18]
	CALL print_output
	CALL new_line
	POP AX
L12:
	MOV AX, 33
	PUSH AX
	POP AX
	CMP AX, 0
	JE L13
	MOV AX, 0
	JMP L14
L13:
	MOV AX, 1
L14:
	PUSH AX
	POP AX
	MOV [BP-18], AX
L15:
	PUSH AX
	MOV AX, [BP-18]
	CALL print_output
	CALL new_line
	POP AX
L16:
	MOV AX, 0
	PUSH AX
	POP AX
	CMP AX, 0
	JE L17
	MOV AX, 0
	JMP L18
L17:
	MOV AX, 1
L18:
	PUSH AX
	POP AX
	MOV [BP-18], AX
L19:
	PUSH AX
	MOV AX, [BP-18]
	CALL print_output
	CALL new_line
	POP AX
L20:
	PUSH AX
	MOV AX, [BP-2]
	CALL print_output
	CALL new_line
	POP AX
L21:
	PUSH AX
	MOV AX, a
	CALL print_output
	CALL new_line
	POP AX
L22:
	MOV AX, 0
	PUSH AX
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, 0
	JE L23
	CMP BX, 0
	JE L23
	MOV AX, 1
	JMP L24
L23:
	MOV AX, 0
L24:
	PUSH AX
	POP AX
	MOV [BP-18], AX
L25:
	PUSH AX
	MOV AX, [BP-18]
	CALL print_output
	CALL new_line
	POP AX
L26:
	MOV AX, 0
	PUSH AX
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	CMP AX, 0
	JE L27
	CMP BX, 0
	JE L27
	MOV AX, 1
	JMP L28
L27:
	MOV AX, 0
L28:
	PUSH AX
	POP AX
	MOV [BP-18], AX
L29:
	PUSH AX
	MOV AX, [BP-18]
	CALL print_output
	CALL new_line
	POP AX
L30:
	MOV AX, 1
	PUSH AX
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, 0
	JE L31
	CMP BX, 0
	JE L31
	MOV AX, 1
	JMP L32
L31:
	MOV AX, 0
L32:
	PUSH AX
	POP AX
	MOV [BP-18], AX
L33:
	PUSH AX
	MOV AX, [BP-18]
	CALL print_output
	CALL new_line
	POP AX
L34:
	MOV AX, 1
	PUSH AX
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	CMP AX, 0
	JE L35
	CMP BX, 0
	JE L35
	MOV AX, 1
	JMP L36
L35:
	MOV AX, 0
L36:
	PUSH AX
	POP AX
	MOV [BP-18], AX
L37:
	PUSH AX
	MOV AX, [BP-18]
	CALL print_output
	CALL new_line
	POP AX
L38:
	MOV AX, 420
	PUSH AX
	MOV AX, 55
	PUSH AX
	POP BX
	POP AX
	CWD
	IDIV BX
	MOV AX, DX
	PUSH AX
	POP AX
	MOV [BP-6], AX
L39:
	PUSH AX
	MOV AX, [BP-6]
	CALL print_output
	CALL new_line
	POP AX
L40:
	MOV AX, 20
	PUSH AX
	MOV AX, 300
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L41
	MOV AX, 0
	JMP L42
L41:
	MOV AX, 1
L42:
	PUSH AX
	POP AX
	MOV [BP-4], AX
L43:
	PUSH AX
	MOV AX, [BP-4]
	CALL print_output
	CALL new_line
	POP AX
L44:
	MOV AX, 20
	PUSH AX
	MOV AX, 300
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JGE L45
	MOV AX, 0
	JMP L46
L45:
	MOV AX, 1
L46:
	PUSH AX
	POP AX
	MOV [BP-4], AX
L47:
	PUSH AX
	MOV AX, [BP-4]
	CALL print_output
	CALL new_line
	POP AX
L48:
	MOV AX, 367
	PUSH AX
	POP AX
	PUSH SI
	PUSH AX
	MOV AX, 1
	PUSH AX
	POP AX
	LEA SI, go
	ADD SI, AX
	ADD SI, AX
	POP AX
	MOV [SI], AX
	POP SI
L49:
	MOV AX, 45
	PUSH AX
	POP AX
	MOV c, AX
L50:
	PUSH AX
	MOV AX, c
	CALL print_output
	CALL new_line
	POP AX
	ADD SP, 26
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
