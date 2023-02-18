.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
	i DW DUP 1(0000H)
	j DW DUP 1(0000H)
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
	SUB SP, 2
	SUB SP, 2
L3:
	MOV AX, 1
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV i, AX
	PUSH AX
	POP AX
L4:
	PUSH AX
	MOV AX, i
	CALL print_output
	CALL new_line
	POP AX
L5:
	MOV AX, 5
	PUSH AX
	MOV AX, 8
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
	MOV j, AX
	PUSH AX
	POP AX
L6:
	PUSH AX
	MOV AX, j
	CALL print_output
	CALL new_line
	POP AX
L7:
	MOV AX, i
	PUSH AX
	MOV AX, 2
	PUSH AX
	MOV AX, j
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
	MOV [BP-2], AX
	PUSH AX
	POP AX
L8:
	PUSH AX
	MOV AX, [BP-2]
	CALL print_output
	CALL new_line
	POP AX
L9:
	MOV AX, [BP-2]
	PUSH AX
	MOV AX, 9
	PUSH AX
	POP BX
	POP AX
	CWD
	IDIV BX
	MOV AX, DX
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
	PUSH AX
	MOV AX, [BP-6]
	CALL print_output
	CALL new_line
	POP AX
L11:
	MOV AX, [BP-6]
	PUSH AX
	MOV AX, [BP-4]
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JLE L12
	MOV AX, 0
	JMP L13
L12:
	MOV AX, 1
L13:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-8], AX
	PUSH AX
	POP AX
L14:
	PUSH AX
	MOV AX, [BP-8]
	CALL print_output
	CALL new_line
	POP AX
L15:
	MOV AX, i
	PUSH AX
	MOV AX, j
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JNE L16
	MOV AX, 0
	JMP L17
L16:
	MOV AX, 1
L17:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-10], AX
	PUSH AX
	POP AX
L18:
	PUSH AX
	MOV AX, [BP-10]
	CALL print_output
	CALL new_line
	POP AX
L19:
	MOV AX, [BP-8]
	PUSH AX
	POP AX
	PUSH AX
	MOV AX, [BP-10]
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	POP AX
	CMP AX, 0
	JNE L20
	CMP BX, 0
	JNE L20
	MOV AX, 0
	JMP L21
L20:
	MOV AX, 1
L21:
	PUSH AX
	POP AX
	MOV [BP-12], AX
	PUSH AX
	POP AX
L22:
	PUSH AX
	MOV AX, [BP-12]
	CALL print_output
	CALL new_line
	POP AX
L23:
	MOV AX, [BP-8]
	PUSH AX
	POP AX
	PUSH AX
	MOV AX, [BP-10]
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	POP AX
	CMP AX, 0
	JE L24
	CMP BX, 0
	JE L24
	MOV AX, 1
	JMP L25
L24:
	MOV AX, 0
L25:
	PUSH AX
	POP AX
	MOV [BP-12], AX
	PUSH AX
	POP AX
L26:
	PUSH AX
	MOV AX, [BP-12]
	CALL print_output
	CALL new_line
	POP AX
L27:
	MOV AX, [BP-12]
	MOV CX, [BP-12]
	INC CX
	MOV [BP-12], CX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
L28:
	PUSH AX
	MOV AX, [BP-12]
	CALL print_output
	CALL new_line
	POP AX
L29:
	MOV AX, [BP-12]
	PUSH AX
	POP AX
	NEG AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-2], AX
	PUSH AX
	POP AX
L30:
	PUSH AX
	MOV AX, [BP-2]
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
	ADD SP, 12
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
