.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
	word1 DW 1 DUP (0000H)
	number1 DW 1 DUP (0000H)
	_j DW 1 DUP (0000H)
	array DW 16 DUP (0000H)
	fib_mem DW 24 DUP (0000H)
	WORD DW 1 DUP (0000H)
.CODE
	;Line no 1 var_declaration
	;Line no 2 var_declaration
	;Line no 4 func_definition
merge1 PROC
	PUSH BP
	MOV BP, SP
	;Line no 4 parameter_list
	;Line no 4 compound_statement
L2:
	;Line no 5 var_declaration
	SUB SP, 2
	SUB SP, 2
L3:
	;Line no 6 var_declaration
	SUB SP, 32
L4:
	;Line no 7 expression_statement
	;Line no 7 expression
	;Line no 7 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 7 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L5:
	;Line no 8 expression_statement
	;Line no 8 expression
	;Line no 8 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	;Line no 8 CONST_INT with value 1
	MOV AX, 1
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
	MOV [BP-4], AX
	PUSH AX
	POP AX
L6:
	;Line no 9 var_declaration
	SUB SP, 2
L7:
	;Line no 10 expression_statement
	;Line no 10 expression
	;Line no 10 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 10 variable assignop
	MOV [BP-38], AX
	PUSH AX
	POP AX
L8:
	;Line no 12 FOR LOOP
	;Line no 12 expression
	;Line no 12 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 12 variable assignop
	MOV [BP-38], AX
	PUSH AX
	POP AX
L9:
	;Line no 12 expression
	;Line no 12 simple_expression with relop
	;Line no 12 variable as factor
	MOV AX, [BP-38]
	PUSH AX
	;Line no 12 expression
	;Line no 12 variable as factor
	MOV AX, [BP+8]
	PUSH AX
	;Line no 12 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP BX
	POP AX
	;Line no 12 term subtraction
	SUB AX, BX
	PUSH AX
	;Line no 12 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	;Line no 12 term addition
	ADD AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L11
	MOV AX, 0
	JMP L12
L11:
	MOV AX, 1
L12:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L10
L13:
	;Line no 12 compound_statement
L14:
	;Line no 13 IF ELSE BLOCK
	;Line no 13 simple_expression with relop
	;Line no 13 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 13 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JG L17
	MOV AX, 0
	JMP L18
L17:
	MOV AX, 1
L18:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L15
L19:
	;Line no 13 expression_statement
	;Line no 13 expression
	;Line no 13 variable as factor
	PUSH SI
	;Line no 13 variable as factor
	;Line no 13 variable INCOP
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
	POP BX
	LEA SI, array
	ADD SI, BX
	ADD SI, BX
	MOV AX, [SI]
	POP SI
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 13 variable assignop
	PUSH SI
	PUSH AX
	;Line no 13 variable as factor
	MOV AX, [BP-38]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	MOV SI, -6
	SUB SI, BX
	SUB SI, BX
	POP AX
	MOV [BP+SI], AX
	POP SI
	PUSH AX
	POP AX
	JMP L16
L15:
L20:
	;Line no 14 IF ELSE BLOCK
	;Line no 14 simple_expression with relop
	;Line no 14 variable as factor
	MOV AX, [BP-4]
	PUSH AX
	;Line no 14 variable as factor
	MOV AX, [BP+8]
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JG L23
	MOV AX, 0
	JMP L24
L23:
	MOV AX, 1
L24:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L21
L25:
	;Line no 14 expression_statement
	;Line no 14 expression
	;Line no 14 variable as factor
	PUSH SI
	;Line no 14 variable as factor
	;Line no 14 variable INCOP
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
	POP BX
	LEA SI, array
	ADD SI, BX
	ADD SI, BX
	MOV AX, [SI]
	POP SI
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 14 variable assignop
	PUSH SI
	PUSH AX
	;Line no 14 variable as factor
	MOV AX, [BP-38]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	MOV SI, -6
	SUB SI, BX
	SUB SI, BX
	POP AX
	MOV [BP+SI], AX
	POP SI
	PUSH AX
	POP AX
	JMP L22
L21:
L26:
	;Line no 15 IF ELSE BLOCK
	;Line no 15 simple_expression with relop
	;Line no 15 variable as factor
	PUSH SI
	;Line no 15 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	LEA SI, array
	ADD SI, BX
	ADD SI, BX
	MOV AX, [SI]
	POP SI
	PUSH AX
	;Line no 15 variable as factor
	PUSH SI
	;Line no 15 variable as factor
	MOV AX, [BP-4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	LEA SI, array
	ADD SI, BX
	ADD SI, BX
	MOV AX, [SI]
	POP SI
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JLE L29
	MOV AX, 0
	JMP L30
L29:
	MOV AX, 1
L30:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L27
L31:
	;Line no 15 expression_statement
	;Line no 15 expression
	;Line no 15 variable as factor
	PUSH SI
	;Line no 15 variable as factor
	;Line no 15 variable INCOP
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
	POP BX
	LEA SI, array
	ADD SI, BX
	ADD SI, BX
	MOV AX, [SI]
	POP SI
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 15 variable assignop
	PUSH SI
	PUSH AX
	;Line no 15 variable as factor
	MOV AX, [BP-38]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	MOV SI, -6
	SUB SI, BX
	SUB SI, BX
	POP AX
	MOV [BP+SI], AX
	POP SI
	PUSH AX
	POP AX
	JMP L28
L27:
L32:
	;Line no 16 expression_statement
	;Line no 16 expression
	;Line no 16 variable as factor
	PUSH SI
	;Line no 16 variable as factor
	;Line no 16 variable INCOP
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
	POP BX
	LEA SI, array
	ADD SI, BX
	ADD SI, BX
	MOV AX, [SI]
	POP SI
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 16 variable assignop
	PUSH SI
	PUSH AX
	;Line no 16 variable as factor
	MOV AX, [BP-38]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	MOV SI, -6
	SUB SI, BX
	SUB SI, BX
	POP AX
	MOV [BP+SI], AX
	POP SI
	PUSH AX
	POP AX
L28:
L22:
L16:
	;Line no 12 variable as factor
	;Line no 12 variable INCOP
	MOV AX, [BP-38]
	MOV CX, [BP-38]
	INC CX
	MOV [BP-38], CX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L9
L10:
L33:
	;Line no 19 FOR LOOP
	;Line no 19 expression
	;Line no 19 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 19 variable assignop
	MOV [BP-38], AX
	PUSH AX
	POP AX
L34:
	;Line no 19 expression
	;Line no 19 simple_expression with relop
	;Line no 19 variable as factor
	MOV AX, [BP-38]
	PUSH AX
	;Line no 19 expression
	;Line no 19 variable as factor
	MOV AX, [BP+8]
	PUSH AX
	;Line no 19 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP BX
	POP AX
	;Line no 19 term subtraction
	SUB AX, BX
	PUSH AX
	;Line no 19 CONST_INT with value 1
	MOV AX, 1
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
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L36
	MOV AX, 0
	JMP L37
L36:
	MOV AX, 1
L37:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L35
L38:
	;Line no 19 compound_statement
L39:
	;Line no 20 expression_statement
	;Line no 20 expression
	;Line no 20 variable as factor
	PUSH SI
	;Line no 20 variable as factor
	MOV AX, [BP-38]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	MOV SI, -6
	SUB SI, BX
	SUB SI, BX
	MOV AX, [BP+SI]
	POP SI
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 20 variable assignop
	PUSH SI
	PUSH AX
	;Line no 20 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 20 variable as factor
	MOV AX, [BP-38]
	PUSH AX
	POP BX
	POP AX
	;Line no 20 term addition
	ADD AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	LEA SI, array
	ADD SI, BX
	ADD SI, BX
	POP AX
	MOV [SI], AX
	POP SI
	PUSH AX
	POP AX
	;Line no 19 variable as factor
	;Line no 19 variable INCOP
	MOV AX, [BP-38]
	MOV CX, [BP-38]
	INC CX
	MOV [BP-38], CX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L34
L35:
L1:
	MOV SP, BP
	POP BP
	RET 6
merge1 ENDP
	;Line no 24 func_definition
mergeSort PROC
	PUSH BP
	MOV BP, SP
	;Line no 24 parameter_list
	;Line no 24 compound_statement
L41:
	;Line no 25 IF BLOCK
	;Line no 25 simple_expression with relop
	;Line no 25 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 25 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JGE L43
	MOV AX, 0
	JMP L44
L43:
	MOV AX, 1
L44:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L42
L45:
	;Line no 26 RETURN STATEMENT
	;Line no 26 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L40
L42:
L46:
	;Line no 28 var_declaration
	SUB SP, 2
L47:
	;Line no 29 expression_statement
	;Line no 29 expression
	;Line no 29 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 29 expression
	;Line no 29 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	;Line no 29 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP BX
	POP AX
	;Line no 29 term subtraction
	SUB AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	;Line no 29 CONST_INT with value 2
	MOV AX, 2
	PUSH AX
	POP BX
	POP AX
	CWD
	;Line no 29 division op
	IDIV BX
	PUSH AX
	POP BX
	POP AX
	;Line no 29 term addition
	ADD AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 29 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L48:
	;Line no 30 expression_statement
	;Line no 30 expression
	;Line no 30mergeSort function call
	;Line no 30 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	;Line no 30 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL mergeSort
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
L49:
	;Line no 31 expression_statement
	;Line no 31 expression
	;Line no 31mergeSort function call
	;Line no 31 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	;Line no 31 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 31 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	;Line no 31 term addition
	ADD AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL mergeSort
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
L50:
	;Line no 32 expression_statement
	;Line no 32 expression
	;Line no 32merge1 function call
	;Line no 32 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	;Line no 32 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	;Line no 32 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL merge1
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
L51:
	;Line no 33 RETURN STATEMENT
	;Line no 33 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L40
L40:
	MOV SP, BP
	POP BP
	RET 4
mergeSort ENDP
	;Line no 36 func_definition
MERGE PROC
	PUSH BP
	MOV BP, SP
	;Line no 36 compound_statement
L53:
	;Line no 37 expression_statement
	;Line no 37 expression
	;Line no 37 CONST_INT with value 15000
	MOV AX, 15000
	PUSH AX
	POP AX
	;Line no 37 NEGATION of factor
	NEG AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 37 variable assignop
	MOV number1, AX
	PUSH AX
	POP AX
L54:
	;Line no 38 println
	MOV AX, number1
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L55:
	;Line no 39 RETURN STATEMENT
	;Line no 39 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L52
L52:
	MOV SP, BP
	POP BP
	RET
MERGE ENDP
	;Line no 42 func_definition
main PROC
	MOV AX, @DATA
	MOV DS, AX
	PUSH BP
	MOV BP, SP
	;Line no 42 compound_statement
L57:
	;Line no 43 var_declaration
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
L58:
	;Line no 44 expression_statement
	;Line no 44 expression
	;Line no 44 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 44 variable assignop
	MOV [BP-4], AX
	PUSH AX
	POP AX
L59:
	;Line no 45 expression_statement
	;Line no 45 expression
	;Line no 45 CONST_INT with value 15
	MOV AX, 15
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 45 variable assignop
	MOV [BP-6], AX
	PUSH AX
	POP AX
L60:
	;Line no 46 expression_statement
	;Line no 46 expression
	;Line no 46mergeSort function call
	;Line no 46 variable as factor
	MOV AX, [BP-6]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	;Line no 46 variable as factor
	MOV AX, [BP-4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL mergeSort
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
L61:
	;Line no 48 FOR LOOP
	;Line no 48 expression
	;Line no 48 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 48 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L62:
	;Line no 48 expression
	;Line no 48 simple_expression with relop
	;Line no 48 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 48 CONST_INT with value 16
	MOV AX, 16
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L64
	MOV AX, 0
	JMP L65
L64:
	MOV AX, 1
L65:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L63
L66:
	;Line no 48 compound_statement
L67:
	;Line no 49 IF BLOCK
	;Line no 49 simple_expression with relop
	;Line no 49 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 49 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JGE L69
	MOV AX, 0
	JMP L70
L69:
	MOV AX, 1
L70:
	PUSH AX
	POP AX
	CMP AX, 0
	JNE L71
	;Line no 49 rel_expression with logicop ||
	;Line no 49MERGE function call
	CALL MERGE
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	CMP BX, 0
	JNE L71
	MOV AX, 0
	JMP L72
L71:
	MOV AX, 1
L72:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L68
L73:
	;Line no 49 compound_statement
L74:
	;Line no 50 expression_statement
	;Line no 50 expression
	;Line no 50 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 50 variable assignop
	MOV WORD, AX
	PUSH AX
	POP AX
L75:
	;Line no 51 expression_statement
	;Line no 51 expression
	;Line no 51 CONST_INT with value 3
	MOV AX, 3
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 51 variable assignop
	MOV WORD, AX
	PUSH AX
	POP AX
L76:
	;Line no 52 expression_statement
	;Line no 52 expression
	;Line no 52 variable as factor
	PUSH SI
	;Line no 52 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	LEA SI, array
	ADD SI, BX
	ADD SI, BX
	MOV AX, [SI]
	POP SI
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 52 variable assignop
	MOV WORD, AX
	PUSH AX
	POP AX
L77:
	;Line no 53 println
	MOV AX, WORD
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L68:
	;Line no 48 variable as factor
	;Line no 48 variable INCOP
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
	JMP L62
L63:
L78:
	;Line no 56 FOR LOOP
	;Line no 56 expression
	;Line no 56 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 56 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L79:
	;Line no 56 expression
	;Line no 56 simple_expression with relop
	;Line no 56 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 56 CONST_INT with value 16
	MOV AX, 16
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L81
	MOV AX, 0
	JMP L82
L81:
	MOV AX, 1
L82:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L80
L83:
	;Line no 57 IF BLOCK
	;Line no 57 simple_expression with relop
	;Line no 57 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 57 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L85
	MOV AX, 0
	JMP L86
L85:
	MOV AX, 1
L86:
	PUSH AX
	POP AX
	CMP AX, 0
	JE L87
	;Line no 57 rel_expression with logicop &&
	;Line no 57MERGE function call
	CALL MERGE
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	CMP BX, 0
	JE L87
	MOV AX, 1
	JMP L88
L87:
	MOV AX, 0
L88:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L84
L89:
	;Line no 57 compound_statement
L90:
	;Line no 58 expression_statement
	;Line no 58 expression
	;Line no 58 variable as factor
	PUSH SI
	;Line no 58 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	LEA SI, array
	ADD SI, BX
	ADD SI, BX
	MOV AX, [SI]
	POP SI
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 58 variable assignop
	MOV _j, AX
	PUSH AX
	POP AX
L91:
	;Line no 59 println
	MOV AX, _j
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L84:
	;Line no 56 variable as factor
	;Line no 56 variable INCOP
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
	JMP L79
L80:
L56:
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
