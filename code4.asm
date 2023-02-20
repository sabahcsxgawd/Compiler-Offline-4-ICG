.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
	c DW DUP 1 (0000H)
	a DW DUP 1 (0000H)
	b DW DUP 1 (0000H)
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
	MOV SP, BP
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
	MOV SP, BP
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
	MOV SP, BP
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
	MOV AX, a
	CALL PRINT_OUTPUT
	CALL NEW_LINE
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
	MOV AX, [BP-6]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
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
	MOV AX, [BP-8]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
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
	MOV AX, [BP-4]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
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
	MOV SP, BP
	POP BP
	MOV AX, 4CH
	INT 21H
main ENDP

PRINT_OUTPUT PROC  ;PRINT WHAT IS IN AX
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	LEA SI, NUMBER
	MOV BX, 10
	ADD SI, 4
	CMP AX, 0
	JNGE NEGATE
PRINT:
	XOR DX, DX
	DIV BX
	MOV [SI], DL
	ADD [SI], '0'
	DEC SI
	CMP AX, 0
	JNE PRINT
	INC SI
	LEA DX, SI
	MOV AH, 9
	INT 21H
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
NEGATE:
	PUSH AX
	MOV AH, 2
	MOV DL, '-'
	INT 21H
	POP AX
	NEG AX
	JMP PRINT
PRINT_OUTPUT ENDP

NEW_LINE PROC
	PUSH AX
	PUSH DX
	MOV AH, 2
	MOV DL, CR
	INT 21H
	MOV AH, 2
	MOV DL, LF
	INT 21H
	POP DX
	POP AX
	RET
NEW_LINE ENDP

END MAIN
