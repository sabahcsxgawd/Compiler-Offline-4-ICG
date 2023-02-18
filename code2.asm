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
L3:
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
L4:
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
L5:
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
L6:
	MOV AX, [BP-2]
	PUSH AX
	MOV AX, 3
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JE L8
	MOV AX, 0
	JMP L9
L8:
	MOV AX, 1
L9:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L7
L10:
L11:
	PUSH AX
	MOV AX, [BP-4]
	CALL print_output
	CALL new_line
	POP AX
L7:
L12:
	MOV AX, [BP-4]
	PUSH AX
	MOV AX, 8
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L15
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
	JE L13
L17:
L18:
	PUSH AX
	MOV AX, [BP-2]
	CALL print_output
	CALL new_line
	POP AX
	JMP L14
L13:
L19:
L20:
	PUSH AX
	MOV AX, [BP-6]
	CALL print_output
	CALL new_line
	POP AX
L14:
L21:
	MOV AX, [BP-6]
	PUSH AX
	MOV AX, 6
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JNE L24
	MOV AX, 0
	JMP L25
L24:
	MOV AX, 1
L25:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L22
L26:
L27:
	PUSH AX
	MOV AX, [BP-6]
	CALL print_output
	CALL new_line
	POP AX
	JMP L23
L22:
L28:
	MOV AX, [BP-4]
	PUSH AX
	MOV AX, 8
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JG L31
	MOV AX, 0
	JMP L32
L31:
	MOV AX, 1
L32:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L29
L33:
L34:
	PUSH AX
	MOV AX, [BP-4]
	CALL print_output
	CALL new_line
	POP AX
	JMP L30
L29:
L35:
	MOV AX, [BP-2]
	PUSH AX
	MOV AX, 5
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L38
	MOV AX, 0
	JMP L39
L38:
	MOV AX, 1
L39:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L36
L40:
L41:
	PUSH AX
	MOV AX, [BP-2]
	CALL print_output
	CALL new_line
	POP AX
	JMP L37
L36:
L42:
L43:
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
L44:
	PUSH AX
	MOV AX, [BP-6]
	CALL print_output
	CALL new_line
	POP AX
L37:
L30:
L23:
L45:
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
	ADD SP, 6
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
