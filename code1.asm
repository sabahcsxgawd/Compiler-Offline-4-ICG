.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
	i DW 1 DUP (0000H)
	j DW 1 DUP (0000H)
.CODE
	;Line no 1 var_declaration
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
	SUB SP, 2
	SUB SP, 2
L3:
	;Line no 6 expression_statement
	;Line no 6 expression
	;Line no 6 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 6 variable assignop
	MOV i, AX
	PUSH AX
	POP AX
L4:
	;Line no 7 println
	MOV AX, i
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L5:
	;Line no 8 expression_statement
	;Line no 8 expression
	;Line no 8 CONST_INT with value 5
	MOV AX, 5
	PUSH AX
	;Line no 8 CONST_INT with value 8
	MOV AX, 8
	PUSH AX
	POP BX
	POP AX
	;Line no 8 term addition
	ADD AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 8 variable assignop
	MOV j, AX
	PUSH AX
	POP AX
L6:
	;Line no 9 println
	MOV AX, j
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L7:
	;Line no 10 expression_statement
	;Line no 10 expression
	;Line no 10 variable as factor
	MOV AX, i
	PUSH AX
	;Line no 10 CONST_INT with value 2
	MOV AX, 2
	PUSH AX
	;Line no 10 variable as factor
	MOV AX, j
	PUSH AX
	POP BX
	POP AX
	CWD
	;Line no 10 multiplication op
	IMUL BX
	PUSH AX
	POP BX
	POP AX
	;Line no 10 term addition
	ADD AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 10 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L8:
	;Line no 11 println
	MOV AX, [BP-2]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L9:
	;Line no 13 expression_statement
	;Line no 13 expression
	;Line no 13 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 13 CONST_INT with value 9
	MOV AX, 9
	PUSH AX
	POP BX
	POP AX
	CWD
	;Line no 13 modulus op
	IDIV BX
	MOV AX, DX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 13 variable assignop
	MOV [BP-6], AX
	PUSH AX
	POP AX
L10:
	;Line no 14 println
	MOV AX, [BP-6]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L11:
	;Line no 16 expression_statement
	;Line no 16 expression
	;Line no 16 simple_expression with relop
	;Line no 16 variable as factor
	MOV AX, [BP-6]
	PUSH AX
	;Line no 16 variable as factor
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
	;Line no 16 variable assignop
	MOV [BP-8], AX
	PUSH AX
	POP AX
L14:
	;Line no 17 println
	MOV AX, [BP-8]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L15:
	;Line no 19 expression_statement
	;Line no 19 expression
	;Line no 19 simple_expression with relop
	;Line no 19 variable as factor
	MOV AX, i
	PUSH AX
	;Line no 19 variable as factor
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
	;Line no 19 variable assignop
	MOV [BP-10], AX
	PUSH AX
	POP AX
L18:
	;Line no 20 println
	MOV AX, [BP-10]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L19:
	;Line no 22 expression_statement
	;Line no 22 expression
	;Line no 22 variable as factor
	MOV AX, [BP-8]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JNE L20
	;Line no 22 rel_expression with logicop ||
	;Line no 22 variable as factor
	MOV AX, [BP-10]
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	CMP BX, 0
	JNE L20
	MOV AX, 0
	JMP L21
L20:
	MOV AX, 1
L21:
	PUSH AX
	POP AX
	;Line no 22 variable assignop
	MOV [BP-12], AX
	PUSH AX
	POP AX
L22:
	;Line no 23 println
	MOV AX, [BP-12]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L23:
	;Line no 25 expression_statement
	;Line no 25 expression
	;Line no 25 variable as factor
	MOV AX, [BP-8]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L24
	;Line no 25 rel_expression with logicop &&
	;Line no 25 variable as factor
	MOV AX, [BP-10]
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	CMP BX, 0
	JE L24
	MOV AX, 1
	JMP L25
L24:
	MOV AX, 0
L25:
	PUSH AX
	POP AX
	;Line no 25 variable assignop
	MOV [BP-12], AX
	PUSH AX
	POP AX
L26:
	;Line no 26 println
	MOV AX, [BP-12]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L27:
	;Line no 28 expression_statement
	;Line no 28 expression
	;Line no 28 variable as factor
	;Line no 28 variable INCOP
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
	;Line no 29 println
	MOV AX, [BP-12]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L29:
	;Line no 31 expression_statement
	;Line no 31 expression
	;Line no 31 variable as factor
	MOV AX, [BP-12]
	PUSH AX
	POP AX
	;Line no 31 NEGATION of factor
	NEG AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 31 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L30:
	;Line no 32 println
	MOV AX, [BP-2]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L31:
	;Line no 37 RETURN STATEMENT
	;Line no 37 CONST_INT with value 0
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
