.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
.CODE
func PROC
	PUSH BP
	MOV BP, SP
L2:
	SUB SP, 2
L3:
	MOV AX, [BP+4]
	PUSH AX
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JE L5
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
L4:
L8:
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-2], AX
	PUSH AX
	POP AX
L9:
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
	CALL func
	PUSH AX
	MOV AX, [BP-2]
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
	ADD SP, 2
	POP BP
	RET 2
func ENDP
func2 PROC
	PUSH BP
	MOV BP, SP
L11:
	SUB SP, 2
L12:
	MOV AX, [BP+4]
	PUSH AX
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JE L14
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
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L10
L13:
L17:
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-2], AX
	PUSH AX
	POP AX
L18:
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
	CALL func
	PUSH AX
	MOV AX, [BP-2]
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
	JMP L10
L10:
	ADD SP, 2
	POP BP
	RET 2
func2 ENDP
main PROC
	MOV AX, @DATA
	MOV DS, AX
	PUSH BP
	MOV BP, SP
L20:
	SUB SP, 2
L21:
	MOV AX, 7
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL func
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	MOV [BP-2], AX
	PUSH AX
	POP AX
L22:
	PUSH AX
	MOV AX, [BP-2]
	CALL print_output
	CALL new_line
	POP AX
L23:
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L19
L19:
	ADD SP, 2
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
