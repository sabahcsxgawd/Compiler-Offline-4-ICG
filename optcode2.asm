.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
.CODE
	;Line no 1 func_definition
main PROC
	MOV AX, @DATA
	MOV DS, AX
	PUSH BP
	MOV BP, SP
	;Line no 1 compound_statement
	;Line no 3 var_declaration
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
	;Line no 5 expression_statement
	;Line no 5 expression
	;Line no 5 CONST_INT with value 3
	MOV AX, 3
	;Line no 5 variable assignop
	MOV [BP-2], AX
	;Line no 6 expression_statement
	;Line no 6 expression
	;Line no 6 CONST_INT with value 8
	MOV AX, 8
	;Line no 6 variable assignop
	MOV [BP-4], AX
	;Line no 7 expression_statement
	;Line no 7 expression
	;Line no 7 CONST_INT with value 6
	MOV AX, 6
	;Line no 7 variable assignop
	MOV [BP-6], AX
	;Line no 10 IF BLOCK
	;Line no 10 simple_expression with relop
	;Line no 10 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 10 CONST_INT with value 3
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
	CMP AX, 0
	JE L7
	;Line no 10 compound_statement
	;Line no 11 println
	MOV AX, [BP-4]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L7:
	;Line no 14 IF ELSE BLOCK
	;Line no 14 simple_expression with relop
	;Line no 14 variable as factor
	MOV AX, [BP-4]
	PUSH AX
	;Line no 14 CONST_INT with value 8
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
	CMP AX, 0
	JE L13
	;Line no 14 compound_statement
	;Line no 15 println
	MOV AX, [BP-2]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
	JMP L14
L13:
	;Line no 17 compound_statement
	;Line no 18 println
	MOV AX, [BP-6]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L14:
	;Line no 21 IF ELSE BLOCK
	;Line no 21 simple_expression with relop
	;Line no 21 variable as factor
	MOV AX, [BP-6]
	PUSH AX
	;Line no 21 CONST_INT with value 6
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
	CMP AX, 0
	JE L22
	;Line no 21 compound_statement
	;Line no 22 println
	MOV AX, [BP-6]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
	JMP L23
L22:
	;Line no 24 IF ELSE BLOCK
	;Line no 24 simple_expression with relop
	;Line no 24 variable as factor
	MOV AX, [BP-4]
	PUSH AX
	;Line no 24 CONST_INT with value 8
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
	CMP AX, 0
	JE L29
	;Line no 24 compound_statement
	;Line no 25 println
	MOV AX, [BP-4]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
	JMP L30
L29:
	;Line no 27 IF ELSE BLOCK
	;Line no 27 simple_expression with relop
	;Line no 27 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 27 CONST_INT with value 5
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
	CMP AX, 0
	JE L36
	;Line no 27 compound_statement
	;Line no 28 println
	MOV AX, [BP-2]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
	JMP L37
L36:
	;Line no 30 compound_statement
	;Line no 31 expression_statement
	;Line no 31 expression
	;Line no 31 CONST_INT with value 0
	MOV AX, 0
	;Line no 31 variable assignop
	MOV [BP-6], AX
	;Line no 32 println
	MOV AX, [BP-6]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L37:
L30:
L23:
	;Line no 36 RETURN STATEMENT
	;Line no 36 CONST_INT with value 0
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
