.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
.CODE
	;Line no 2 func_definition
main PROC
	MOV AX, @DATA
	MOV DS, AX
	PUSH BP
	MOV BP, SP
	;Line no 2 compound_statement
L2:
	;Line no 4 var_declaration
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
L3:
	;Line no 6 FOR LOOP
	;Line no 6 expression
	;Line no 6 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 6 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L4:
	;Line no 6 expression
	;Line no 6 simple_expression with relop
	;Line no 6 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 6 CONST_INT with value 6
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
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L5
L8:
	;Line no 6 compound_statement
L9:
	;Line no 7 println
	MOV AX, [BP-2]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
	;Line no 6 variable as factor
	;Line no 6 variable INCOP
	MOV AX, [BP-2]
	MOV CX, [BP-2]
	INC CX
	MOV [BP-2], CX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L4
L5:
L10:
	;Line no 10 expression_statement
	;Line no 10 expression
	;Line no 10 CONST_INT with value 4
	MOV AX, 4
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 10 variable assignop
	MOV [BP-6], AX
	PUSH AX
	POP AX
L11:
	;Line no 11 expression_statement
	;Line no 11 expression
	;Line no 11 CONST_INT with value 6
	MOV AX, 6
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 11 variable assignop
	MOV [BP-8], AX
	PUSH AX
	POP AX
L12:
	;Line no 12 WHILE LOOP
L13:
	;Line no 12 simple_expression with relop
	;Line no 12 variable as factor
	MOV AX, [BP-6]
	PUSH AX
	;Line no 12 CONST_INT with value 0
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
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L14
L17:
	;Line no 12 compound_statement
L18:
	;Line no 13 expression_statement
	;Line no 13 expression
	;Line no 13 variable as factor
	MOV AX, [BP-8]
	PUSH AX
	;Line no 13 CONST_INT with value 3
	MOV AX, 3
	PUSH AX
	POP BX
	POP AX
	;Line no 13 term addition
	ADD AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 13 variable assignop
	MOV [BP-8], AX
	PUSH AX
	POP AX
L19:
	;Line no 14 expression_statement
	;Line no 14 expression
	;Line no 14 variable as factor
	;Line no 14 variable DECOP
	MOV AX, [BP-6]
	MOV CX, [BP-6]
	DEC CX
	MOV [BP-6], CX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L13
L14:
L20:
	;Line no 17 println
	MOV AX, [BP-8]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L21:
	;Line no 18 println
	MOV AX, [BP-6]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L22:
	;Line no 20 expression_statement
	;Line no 20 expression
	;Line no 20 CONST_INT with value 4
	MOV AX, 4
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 20 variable assignop
	MOV [BP-6], AX
	PUSH AX
	POP AX
L23:
	;Line no 21 expression_statement
	;Line no 21 expression
	;Line no 21 CONST_INT with value 6
	MOV AX, 6
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 21 variable assignop
	MOV [BP-8], AX
	PUSH AX
	POP AX
L24:
	;Line no 23 WHILE LOOP
L25:
	;Line no 23 variable as factor
	;Line no 23 variable DECOP
	MOV AX, [BP-6]
	MOV CX, [BP-6]
	DEC CX
	MOV [BP-6], CX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L26
L27:
	;Line no 23 compound_statement
L28:
	;Line no 24 expression_statement
	;Line no 24 expression
	;Line no 24 variable as factor
	MOV AX, [BP-8]
	PUSH AX
	;Line no 24 CONST_INT with value 3
	MOV AX, 3
	PUSH AX
	POP BX
	POP AX
	;Line no 24 term addition
	ADD AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 24 variable assignop
	MOV [BP-8], AX
	PUSH AX
	POP AX
	JMP L25
L26:
L29:
	;Line no 27 println
	MOV AX, [BP-8]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L30:
	;Line no 28 println
	MOV AX, [BP-6]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L31:
	;Line no 30 RETURN STATEMENT
	;Line no 30 CONST_INT with value 0
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
