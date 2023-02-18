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
L2:
	MOV AX, 3
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
	MOV AX, 8
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-4], AX
	PUSH AX
	POP AX
L4:
	MOV AX, 6
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-6], AX
	PUSH AX
	POP AX
L5:
	MOV AX, [BP-2]
	PUSH AX
	MOV AX, 3
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JE L7
	MOV AX, 0
	JMP L8
L7:
	MOV AX, 1
L8:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L6
L9:
L10:
	PUSH AX
	MOV AX, [BP-4]
	CALL print_output
	CALL new_line
	POP AX
L6:
L11:
	MOV AX, [BP-4]
	PUSH AX
	MOV AX, 8
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L14
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
	JE L12
L16:
L17:
	PUSH AX
	MOV AX, [BP-2]
	CALL print_output
	CALL new_line
	POP AX
	JMP L13
L12:
L18:
L19:
	PUSH AX
	MOV AX, [BP-6]
	CALL print_output
	CALL new_line
	POP AX
L13:
L20:
	MOV AX, [BP-6]
	PUSH AX
	MOV AX, 6
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JNE L23
	MOV AX, 0
	JMP L24
L23:
	MOV AX, 1
L24:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L21
L25:
L26:
	PUSH AX
	MOV AX, [BP-6]
	CALL print_output
	CALL new_line
	POP AX
	JMP L22
L21:
L27:
	MOV AX, [BP-4]
	PUSH AX
	MOV AX, 8
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JG L30
	MOV AX, 0
	JMP L31
L30:
	MOV AX, 1
L31:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L28
L32:
L33:
	PUSH AX
	MOV AX, [BP-4]
	CALL print_output
	CALL new_line
	POP AX
	JMP L29
L28:
L34:
	MOV AX, [BP-2]
	PUSH AX
	MOV AX, 5
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L37
	MOV AX, 0
	JMP L38
L37:
	MOV AX, 1
L38:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L35
L39:
L40:
	PUSH AX
	MOV AX, [BP-2]
	CALL print_output
	CALL new_line
	POP AX
	JMP L36
L35:
L41:
L42:
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-6], AX
	PUSH AX
	POP AX
L43:
	PUSH AX
	MOV AX, [BP-6]
	CALL print_output
	CALL new_line
	POP AX
L36:
L29:
L22:
L44:
	ADD SP, 6
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
