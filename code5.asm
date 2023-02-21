.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
.CODE
	;Line no 1 func_definition
f PROC
	PUSH BP
	MOV BP, SP
	;Line no 1 parameter_list
	;Line no 1 compound_statement
L2:
	;Line no 2 var_declaration
	SUB SP, 2
L3:
	;Line no 3 expression_statement
	;Line no 3 expression
	;Line no 3 CONST_INT with value 5
	MOV AX, 5
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 3 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L4:
	;Line no 4 WHILE LOOP
L5:
	;Line no 4 simple_expression with relop
	;Line no 4 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 4 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JG L7
	MOV AX, 0
	JMP L8
L7:
	MOV AX, 1
L8:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L6
L9:
	;Line no 4 compound_statement
L10:
	;Line no 5 expression_statement
	;Line no 5 expression
	;Line no 5 variable as factor
	;Line no 5 variable INCOP
	MOV AX, [BP+4]
	MOV CX, [BP+4]
	INC CX
	MOV [BP+4], CX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
L11:
	;Line no 6 expression_statement
	;Line no 6 expression
	;Line no 6 variable as factor
	;Line no 6 variable DECOP
	MOV AX, [BP-2]
	MOV CX, [BP-2]
	DEC CX
	MOV [BP-2], CX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L5
L6:
L12:
	;Line no 8 RETURN STATEMENT
	;Line no 8 CONST_INT with value 3
	MOV AX, 3
	PUSH AX
	;Line no 8 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP BX
	POP AX
	CWD
	;Line no 8 multiplication op
	IMUL BX
	PUSH AX
	;Line no 8 CONST_INT with value 7
	MOV AX, 7
	PUSH AX
	POP BX
	POP AX
	;Line no 8 term subtraction
	SUB AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L1
L13:
	;Line no 9 expression_statement
	;Line no 9 expression
	;Line no 9 CONST_INT with value 9
	MOV AX, 9
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 9 variable assignop
	MOV [BP+4], AX
	PUSH AX
	POP AX
L1:
	MOV SP, BP
	POP BP
	RET 2
f ENDP
	;Line no 12 func_definition
g PROC
	PUSH BP
	MOV BP, SP
	;Line no 12 parameter_list
	;Line no 12 compound_statement
L15:
	;Line no 14 var_declaration
	SUB SP, 2
	SUB SP, 2
L16:
	;Line no 15 expression_statement
	;Line no 15 expression
	;Line no 15f function call
	;Line no 15 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL f
	PUSH AX
	;Line no 15 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP BX
	POP AX
	;Line no 15 term addition
	ADD AX, BX
	PUSH AX
	;Line no 15 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	POP BX
	POP AX
	;Line no 15 term addition
	ADD AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 15 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L17:
	;Line no 17 FOR LOOP
	;Line no 17 expression
	;Line no 17 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 17 variable assignop
	MOV [BP-4], AX
	PUSH AX
	POP AX
L18:
	;Line no 17 expression
	;Line no 17 simple_expression with relop
	;Line no 17 variable as factor
	MOV AX, [BP-4]
	PUSH AX
	;Line no 17 CONST_INT with value 7
	MOV AX, 7
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L20
	MOV AX, 0
	JMP L21
L20:
	MOV AX, 1
L21:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L19
L22:
	;Line no 17 compound_statement
L23:
	;Line no 18 IF ELSE BLOCK
	;Line no 18 simple_expression with relop
	;Line no 18 variable as factor
	MOV AX, [BP-4]
	PUSH AX
	;Line no 18 CONST_INT with value 3
	MOV AX, 3
	PUSH AX
	POP BX
	POP AX
	CWD
	;Line no 18 modulus op
	IDIV BX
	MOV AX, DX
	PUSH AX
	;Line no 18 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JE L26
	MOV AX, 0
	JMP L27
L26:
	MOV AX, 1
L27:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L24
L28:
	;Line no 18 compound_statement
L29:
	;Line no 19 expression_statement
	;Line no 19 expression
	;Line no 19 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 19 CONST_INT with value 5
	MOV AX, 5
	PUSH AX
	POP BX
	POP AX
	;Line no 19 term addition
	ADD AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 19 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
	JMP L25
L24:
L30:
	;Line no 21 compound_statement
L31:
	;Line no 22 expression_statement
	;Line no 22 expression
	;Line no 22 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 22 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	;Line no 22 term subtraction
	SUB AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 22 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L25:
	;Line no 17 variable as factor
	;Line no 17 variable INCOP
	MOV AX, [BP-4]
	MOV CX, [BP-4]
	INC CX
	MOV [BP-4], CX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L18
L19:
L32:
	;Line no 26 RETURN STATEMENT
	;Line no 26 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L14
L14:
	MOV SP, BP
	POP BP
	RET 4
g ENDP
	;Line no 29 func_definition
main PROC
	MOV AX, @DATA
	MOV DS, AX
	PUSH BP
	MOV BP, SP
	;Line no 29 compound_statement
L34:
	;Line no 30 var_declaration
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
L35:
	;Line no 31 expression_statement
	;Line no 31 expression
	;Line no 31 CONST_INT with value 1
	MOV AX, 1
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
L36:
	;Line no 32 expression_statement
	;Line no 32 expression
	;Line no 32 CONST_INT with value 2
	MOV AX, 2
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 32 variable assignop
	MOV [BP-4], AX
	PUSH AX
	POP AX
L37:
	;Line no 33 expression_statement
	;Line no 33 expression
	;Line no 33g function call
	;Line no 33 variable as factor
	MOV AX, [BP-4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	;Line no 33 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL g
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 33 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L38:
	;Line no 34 println
	MOV AX, [BP-2]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L39:
	;Line no 35 FOR LOOP
	;Line no 35 expression
	;Line no 35 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 35 variable assignop
	MOV [BP-6], AX
	PUSH AX
	POP AX
L40:
	;Line no 35 expression
	;Line no 35 simple_expression with relop
	;Line no 35 variable as factor
	MOV AX, [BP-6]
	PUSH AX
	;Line no 35 CONST_INT with value 4
	MOV AX, 4
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L42
	MOV AX, 0
	JMP L43
L42:
	MOV AX, 1
L43:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L41
L44:
	;Line no 35 compound_statement
L45:
	;Line no 36 expression_statement
	;Line no 36 expression
	;Line no 36 CONST_INT with value 3
	MOV AX, 3
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 36 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L46:
	;Line no 37 WHILE LOOP
L47:
	;Line no 37 simple_expression with relop
	;Line no 37 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 37 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JG L49
	MOV AX, 0
	JMP L50
L49:
	MOV AX, 1
L50:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L48
L51:
	;Line no 37 compound_statement
L52:
	;Line no 38 expression_statement
	;Line no 38 expression
	;Line no 38 variable as factor
	;Line no 38 variable INCOP
	MOV AX, [BP-4]
	MOV CX, [BP-4]
	INC CX
	MOV [BP-4], CX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
L53:
	;Line no 39 expression_statement
	;Line no 39 expression
	;Line no 39 variable as factor
	;Line no 39 variable DECOP
	MOV AX, [BP-2]
	MOV CX, [BP-2]
	DEC CX
	MOV [BP-2], CX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L47
L48:
	;Line no 35 variable as factor
	;Line no 35 variable INCOP
	MOV AX, [BP-6]
	MOV CX, [BP-6]
	INC CX
	MOV [BP-6], CX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L40
L41:
L54:
	;Line no 42 println
	MOV AX, [BP-2]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L55:
	;Line no 43 println
	MOV AX, [BP-4]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L56:
	;Line no 44 println
	MOV AX, [BP-6]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L57:
	;Line no 45 RETURN STATEMENT
	;Line no 45 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L33
L33:
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
