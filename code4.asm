.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
	c DW DUP 1(0000H)
	a DW DUP 1(0000H)
	b DW DUP 1(0000H)
.CODE
func_a PROC
	PUSH BP
	MOV BP, SP
L2:
	MOV AX, 7
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV a, AX
	PUSH AX
	POP AX
L1:
	ADD SP, 0
	POP BP
	RET
func_a ENDP
foo PROC
	PUSH BP
	MOV BP, SP
L4:
	MOV AX, [BP+4]
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
	MOV [BP+4], AX
	PUSH AX
	POP AX
L5:
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L3
L3:
	ADD SP, 0
	POP BP
	RET 2
foo ENDP
bar PROC
	PUSH BP
	MOV BP, SP
L7:
	MOV AX, 4
	PUSH AX
	MOV AX, [BP+4]
	PUSH AX
	POP BX
	POP AX
	CWD
	IMUL BX
	PUSH AX
	MOV AX, 2
	PUSH AX
	MOV AX, [BP+6]
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
	MOV c, AX
	PUSH AX
	POP AX
L8:
	MOV AX, c
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L6
L6:
	ADD SP, 0
	POP BP
	RET 4
bar ENDP
main PROC
	MOV AX, @DATA
	MOV DS, AX
	PUSH BP
	MOV BP, SP
L10:
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
L11:
	MOV AX, 5
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
	MOV AX, 6
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
	CALL func_a
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
L14:
	PUSH AX
	MOV AX, a
	CALL print_output
	CALL new_line
	POP AX
L15:
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
L16:
	PUSH AX
	MOV AX, [BP-6]
	CALL print_output
	CALL new_line
	POP AX
L17:
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
	CALL bar
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
	PUSH AX
	MOV AX, [BP-8]
	CALL print_output
	CALL new_line
	POP AX
L19:
	MOV AX, 6
	PUSH AX
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
	CALL bar
	PUSH AX
	POP BX
	POP AX
	CWD
	IMUL BX
	PUSH AX
	MOV AX, 2
	PUSH AX
	POP BX
	POP AX
	ADD AX, BX
	PUSH AX
	MOV AX, 3
	PUSH AX
	MOV AX, [BP-2]
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
	SUB AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-4], AX
	PUSH AX
	POP AX
L20:
	PUSH AX
	MOV AX, [BP-4]
	CALL print_output
	CALL new_line
	POP AX
L21:
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
