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
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
	MOV AX, 0
	MOV [BP-2], AX
L4:
	MOV AX, [BP-2]
	PUSH AX
	MOV AX, 6
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L6
	MOV AX, 0
	JMP L7
L6:
	MOV AX, 1
L7:
	CMP AX, 0
	JE L5
	MOV AX, [BP-2]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
	MOV AX, [BP-2]
	MOV CX, [BP-2]
	INC CX
	MOV [BP-2], CX
	JMP L4
L5:
	MOV AX, 4
	MOV [BP-6], AX
	MOV AX, 6
	MOV [BP-8], AX
L13:
	MOV AX, [BP-6]
	PUSH AX
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JG L15
	MOV AX, 0
	JMP L16
L15:
	MOV AX, 1
L16:
	CMP AX, 0
	JE L14
	MOV AX, [BP-8]
	PUSH AX
	MOV AX, 3
	PUSH AX
	POP BX
	POP AX
	ADD AX, BX
	MOV [BP-8], AX
	MOV AX, [BP-6]
	MOV CX, [BP-6]
	DEC CX
	MOV [BP-6], CX
	JMP L13
L14:
	MOV AX, [BP-8]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
	MOV AX, [BP-6]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
	MOV AX, 4
	MOV [BP-6], AX
	MOV AX, 6
	MOV [BP-8], AX
L25:
	MOV AX, [BP-6]
	MOV CX, [BP-6]
	DEC CX
	MOV [BP-6], CX
	CMP AX, 0
	JE L26
	MOV AX, [BP-8]
	PUSH AX
	MOV AX, 3
	PUSH AX
	POP BX
	POP AX
	ADD AX, BX
	MOV [BP-8], AX
	JMP L25
L26:
	MOV AX, [BP-8]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
	MOV AX, [BP-6]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
	MOV AX, 0
	JMP L1
L1:
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
