.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
.CODE
foo PROC
	PUSH BP
	MOV BP, SP
L2:
	MOV AX, [BP+4]
	PUSH AX
	MOV AX, [BP+6]
	PUSH AX
	POP BX
	POP AX
	ADD AX, BX
	PUSH AX
	MOV AX, 5
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JLE L4
	MOV AX, 0
	JMP L5
L4:
	MOV AX, 1
L5:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L3
L6:
L7:
	MOV AX, 7
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L1
L3:
L8:
	MOV AX, [BP+6]
	PUSH AX
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	SUB AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	MOV AX, [BP+4]
	PUSH AX
	MOV AX, 2
	PUSH AX
	POP BX
	POP AX
	SUB AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL foo
	PUSH AX
	MOV AX, 2
	PUSH AX
	MOV AX, [BP+6]
	PUSH AX
	MOV AX, 2
	PUSH AX
	POP BX
	POP AX
	SUB AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	MOV AX, [BP+4]
	PUSH AX
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	SUB AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL foo
	PUSH AX
	POP BX
	POP AX
	CWD
	IMUL BX
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
	PUSH AX
	POP AX
	JMP L1
L1:
	ADD SP, 0
	POP BP
	RET 4
foo ENDP
main PROC
	MOV AX, @DATA
	MOV DS, AX
	PUSH BP
	MOV BP, SP
L10:
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
L11:
	MOV AX, 7
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-2], AX
	PUSH AX
	POP AX
L12:
	MOV AX, 3
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-4], AX
	PUSH AX
	POP AX
L13:
	MOV AX, [BP-4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	MOV AX, [BP-2]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL foo
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-6], AX
	PUSH AX
	POP AX
L14:
	PUSH AX
	MOV AX, [BP-6]
	CALL print_output
	CALL new_line
	POP AX
L15:
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L9
L9:
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
