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
	CMP AX, 0
	JE L3
	MOV AX, 7
	JMP L1
L3:
	MOV AX, [BP+6]
	PUSH AX
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	SUB AX, BX
	PUSH AX
	MOV AX, [BP+4]
	PUSH AX
	MOV AX, 2
	PUSH AX
	POP BX
	POP AX
	SUB AX, BX
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
	MOV AX, [BP+4]
	PUSH AX
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	SUB AX, BX
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
	JMP L1
L1:
	MOV SP, BP
	POP BP
	RET 4
foo ENDP
main PROC
	MOV AX, @DATA
	MOV DS, AX
	PUSH BP
	MOV BP, SP
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
	MOV AX, 7
	MOV [BP-2], AX
	MOV AX, 3
	MOV [BP-4], AX
	PUSH AX
	MOV AX, [BP-2]
	PUSH AX
	CALL foo
	MOV [BP-6], AX
	CALL PRINT_OUTPUT
	CALL NEW_LINE
	MOV AX, 0
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
