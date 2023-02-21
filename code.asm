.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
	word1 DW 1 DUP (0000H)
	word2 DW 1 DUP (0000H)
	__number DW 1 DUP (0000H)
	_j DW 1 DUP (0000H)
	array DW 16 DUP (0000H)
	fib_mem DW 24 DUP (0000H)
.CODE
	;Line no 2 var_declaration
	;Line no 3 var_declaration
	;Line no 9 func_definition
fibonacci PROC
	PUSH BP
	MOV BP, SP
	;Line no 9 parameter_list
	;Line no 9 compound_statement
L2:
	;Line no 10 IF BLOCK
	;Line no 10 simple_expression with relop
	;Line no 10 variable as factor
	PUSH SI
	;Line no 10 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	LEA SI, fib_mem
	ADD SI, BX
	ADD SI, BX
	MOV AX, [SI]
	POP SI
	PUSH AX
	;Line no 10 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JNE L4
	MOV AX, 0
	JMP L5
L4:
	MOV AX, 1
L5:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L3
L6:
	;Line no 10 RETURN STATEMENT
	;Line no 10 variable as factor
	PUSH SI
	;Line no 10 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	LEA SI, fib_mem
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
	PUSH AX
	POP AX
	JMP L1
L3:
L7:
	;Line no 11 IF BLOCK
	;Line no 11 simple_expression with relop
	;Line no 11 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 11 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JE L9
	MOV AX, 0
	JMP L10
L9:
	MOV AX, 1
L10:
	PUSH AX
	POP AX
	CMP AX, 0
	JNE L11
	;Line no 11 rel_expression with logicop ||
	;Line no 11 simple_expression with relop
	;Line no 11 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 11 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JE L13
	MOV AX, 0
	JMP L14
L13:
	MOV AX, 1
L14:
	PUSH AX
	POP BX
	CMP BX, 0
	JNE L11
	MOV AX, 0
	JMP L12
L11:
	MOV AX, 1
L12:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L8
L15:
	;Line no 11 compound_statement
L16:
	;Line no 12 expression_statement
	;Line no 12 expression
	;Line no 12 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 12 variable assignop
	PUSH SI
	PUSH AX
	;Line no 12 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	LEA SI, fib_mem
	ADD SI, BX
	ADD SI, BX
	POP AX
	MOV [SI], AX
	POP SI
	PUSH AX
	POP AX
L17:
	;Line no 13 RETURN STATEMENT
	;Line no 13 variable as factor
	PUSH SI
	;Line no 13 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	LEA SI, fib_mem
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
	PUSH AX
	POP AX
	JMP L1
L8:
L18:
	;Line no 15 expression_statement
	;Line no 15 expression
	;Line no 15fibonacci function call
	;Line no 15 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 15 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	;Line no 15 term subtraction
	SUB AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL fibonacci
	PUSH AX
	;Line no 15fibonacci function call
	;Line no 15 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 15 CONST_INT with value 2
	MOV AX, 2
	PUSH AX
	POP BX
	POP AX
	;Line no 15 term subtraction
	SUB AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL fibonacci
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
	PUSH SI
	PUSH AX
	;Line no 15 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	LEA SI, fib_mem
	ADD SI, BX
	ADD SI, BX
	POP AX
	MOV [SI], AX
	POP SI
	PUSH AX
	POP AX
L19:
	;Line no 16 RETURN STATEMENT
	;Line no 16 variable as factor
	PUSH SI
	;Line no 16 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	LEA SI, fib_mem
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
	PUSH AX
	POP AX
	JMP L1
L1:
	MOV SP, BP
	POP BP
	RET 2
fibonacci ENDP
	;Line no 19 func_definition
factorial PROC
	PUSH BP
	MOV BP, SP
	;Line no 19 parameter_list
	;Line no 19 compound_statement
L21:
	;Line no 20 IF BLOCK
	;Line no 20 simple_expression with relop
	;Line no 20 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 20 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JE L23
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
	JE L22
L25:
	;Line no 20 RETURN STATEMENT
	;Line no 20 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L20
L22:
L26:
	;Line no 21 var_declaration
	SUB SP, 2
L27:
	;Line no 22 expression_statement
	;Line no 22 expression
	;Line no 22 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 22factorial function call
	;Line no 22 variable as factor
	MOV AX, [BP+4]
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
	CALL factorial
	PUSH AX
	POP BX
	POP AX
	CWD
	;Line no 22 multiplication op
	IMUL BX
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
L28:
	;Line no 23 RETURN STATEMENT
	;Line no 23 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L20
L20:
	MOV SP, BP
	POP BP
	RET 2
factorial ENDP
	;Line no 26 func_definition
power PROC
	PUSH BP
	MOV BP, SP
	;Line no 26 parameter_list
	;Line no 26 compound_statement
L30:
	;Line no 27 IF BLOCK
	;Line no 27 simple_expression with relop
	;Line no 27 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	;Line no 27 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JE L32
	MOV AX, 0
	JMP L33
L32:
	MOV AX, 1
L33:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L31
L34:
	;Line no 27 RETURN STATEMENT
	;Line no 27 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L29
L31:
L35:
	;Line no 28 RETURN STATEMENT
	;Line no 28 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 28power function call
	;Line no 28 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	;Line no 28 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	;Line no 28 term subtraction
	SUB AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	;Line no 28 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL power
	PUSH AX
	POP BX
	POP AX
	CWD
	;Line no 28 multiplication op
	IMUL BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L29
L29:
	MOV SP, BP
	POP BP
	RET 4
power ENDP
	;Line no 31 func_definition
merge PROC
	PUSH BP
	MOV BP, SP
	;Line no 31 parameter_list
	;Line no 31 compound_statement
L37:
	;Line no 32 var_declaration
	SUB SP, 2
	SUB SP, 2
L38:
	;Line no 33 var_declaration
	SUB SP, 32
L39:
	;Line no 34 expression_statement
	;Line no 34 expression
	;Line no 34 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 34 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L40:
	;Line no 35 expression_statement
	;Line no 35 expression
	;Line no 35 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	;Line no 35 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	;Line no 35 term addition
	ADD AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 35 variable assignop
	MOV [BP-4], AX
	PUSH AX
	POP AX
L41:
	;Line no 36 var_declaration
	SUB SP, 2
L42:
	;Line no 37 expression_statement
	;Line no 37 expression
	;Line no 37 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 37 variable assignop
	MOV [BP-38], AX
	PUSH AX
	POP AX
L43:
	;Line no 39 FOR LOOP
	;Line no 39 expression
	;Line no 39 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 39 variable assignop
	MOV [BP-38], AX
	PUSH AX
	POP AX
L44:
	;Line no 39 expression
	;Line no 39 simple_expression with relop
	;Line no 39 variable as factor
	MOV AX, [BP-38]
	PUSH AX
	;Line no 39 expression
	;Line no 39 variable as factor
	MOV AX, [BP+8]
	PUSH AX
	;Line no 39 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP BX
	POP AX
	;Line no 39 term subtraction
	SUB AX, BX
	PUSH AX
	;Line no 39 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	;Line no 39 term addition
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
	JL L46
	MOV AX, 0
	JMP L47
L46:
	MOV AX, 1
L47:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L45
L48:
	;Line no 39 compound_statement
L49:
	;Line no 40 IF ELSE BLOCK
	;Line no 40 simple_expression with relop
	;Line no 40 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 40 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JG L52
	MOV AX, 0
	JMP L53
L52:
	MOV AX, 1
L53:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L50
L54:
	;Line no 40 expression_statement
	;Line no 40 expression
	;Line no 40 variable as factor
	PUSH SI
	;Line no 40 variable as factor
	;Line no 40 variable INCOP
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
	;Line no 40 variable assignop
	PUSH SI
	PUSH AX
	;Line no 40 variable as factor
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
	JMP L51
L50:
L55:
	;Line no 41 IF ELSE BLOCK
	;Line no 41 simple_expression with relop
	;Line no 41 variable as factor
	MOV AX, [BP-4]
	PUSH AX
	;Line no 41 variable as factor
	MOV AX, [BP+8]
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JG L58
	MOV AX, 0
	JMP L59
L58:
	MOV AX, 1
L59:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L56
L60:
	;Line no 41 expression_statement
	;Line no 41 expression
	;Line no 41 variable as factor
	PUSH SI
	;Line no 41 variable as factor
	;Line no 41 variable INCOP
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
	;Line no 41 variable assignop
	PUSH SI
	PUSH AX
	;Line no 41 variable as factor
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
	JMP L57
L56:
L61:
	;Line no 42 IF ELSE BLOCK
	;Line no 42 simple_expression with relop
	;Line no 42 variable as factor
	PUSH SI
	;Line no 42 variable as factor
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
	;Line no 42 variable as factor
	PUSH SI
	;Line no 42 variable as factor
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
	JLE L64
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
	JE L62
L66:
	;Line no 42 expression_statement
	;Line no 42 expression
	;Line no 42 variable as factor
	PUSH SI
	;Line no 42 variable as factor
	;Line no 42 variable INCOP
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
	;Line no 42 variable assignop
	PUSH SI
	PUSH AX
	;Line no 42 variable as factor
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
	JMP L63
L62:
L67:
	;Line no 43 expression_statement
	;Line no 43 expression
	;Line no 43 variable as factor
	PUSH SI
	;Line no 43 variable as factor
	;Line no 43 variable INCOP
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
	;Line no 43 variable assignop
	PUSH SI
	PUSH AX
	;Line no 43 variable as factor
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
L63:
L57:
L51:
	;Line no 39 variable as factor
	;Line no 39 variable INCOP
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
	JMP L44
L45:
L68:
	;Line no 46 FOR LOOP
	;Line no 46 expression
	;Line no 46 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 46 variable assignop
	MOV [BP-38], AX
	PUSH AX
	POP AX
L69:
	;Line no 46 expression
	;Line no 46 simple_expression with relop
	;Line no 46 variable as factor
	MOV AX, [BP-38]
	PUSH AX
	;Line no 46 expression
	;Line no 46 variable as factor
	MOV AX, [BP+8]
	PUSH AX
	;Line no 46 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP BX
	POP AX
	;Line no 46 term subtraction
	SUB AX, BX
	PUSH AX
	;Line no 46 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	;Line no 46 term addition
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
	JL L71
	MOV AX, 0
	JMP L72
L71:
	MOV AX, 1
L72:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L70
L73:
	;Line no 46 compound_statement
L74:
	;Line no 47 expression_statement
	;Line no 47 expression
	;Line no 47 variable as factor
	PUSH SI
	;Line no 47 variable as factor
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
	;Line no 47 variable assignop
	PUSH SI
	PUSH AX
	;Line no 47 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 47 variable as factor
	MOV AX, [BP-38]
	PUSH AX
	POP BX
	POP AX
	;Line no 47 term addition
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
	;Line no 46 variable as factor
	;Line no 46 variable INCOP
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
	JMP L69
L70:
L36:
	MOV SP, BP
	POP BP
	RET 6
merge ENDP
	;Line no 51 func_definition
mergeSort PROC
	PUSH BP
	MOV BP, SP
	;Line no 51 parameter_list
	;Line no 51 compound_statement
L76:
	;Line no 52 IF BLOCK
	;Line no 52 simple_expression with relop
	;Line no 52 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 52 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JGE L78
	MOV AX, 0
	JMP L79
L78:
	MOV AX, 1
L79:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L77
L80:
	;Line no 53 RETURN STATEMENT
	;Line no 53 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L75
L77:
L81:
	;Line no 55 var_declaration
	SUB SP, 2
L82:
	;Line no 56 expression_statement
	;Line no 56 expression
	;Line no 56 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 56 expression
	;Line no 56 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	;Line no 56 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP BX
	POP AX
	;Line no 56 term subtraction
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
	;Line no 56 CONST_INT with value 2
	MOV AX, 2
	PUSH AX
	POP BX
	POP AX
	CWD
	;Line no 56 division op
	IDIV BX
	PUSH AX
	POP BX
	POP AX
	;Line no 56 term addition
	ADD AX, BX
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
L83:
	;Line no 57 expression_statement
	;Line no 57 expression
	;Line no 57mergeSort function call
	;Line no 57 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	;Line no 57 variable as factor
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
L84:
	;Line no 58 expression_statement
	;Line no 58 expression
	;Line no 58mergeSort function call
	;Line no 58 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	;Line no 58 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 58 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	;Line no 58 term addition
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
L85:
	;Line no 59 expression_statement
	;Line no 59 expression
	;Line no 59merge function call
	;Line no 59 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	;Line no 59 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	;Line no 59 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL merge
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
L86:
	;Line no 60 RETURN STATEMENT
	;Line no 60 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L75
L75:
	MOV SP, BP
	POP BP
	RET 4
mergeSort ENDP
	;Line no 63 func_definition
__MERGE PROC
	PUSH BP
	MOV BP, SP
	;Line no 63 compound_statement
L88:
	;Line no 64 expression_statement
	;Line no 64 expression
	;Line no 64 CONST_INT with value 15000
	MOV AX, 15000
	PUSH AX
	POP AX
	;Line no 64 NEGATION of factor
	NEG AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 64 variable assignop
	MOV __number, AX
	PUSH AX
	POP AX
L89:
	;Line no 65 println
	MOV AX, __number
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L90:
	;Line no 66 RETURN STATEMENT
	;Line no 66 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L87
L87:
	MOV SP, BP
	POP BP
	RET
__MERGE ENDP
	;Line no 69 func_definition
loop_test PROC
	PUSH BP
	MOV BP, SP
	;Line no 69 compound_statement
L92:
	;Line no 70 var_declaration
	SUB SP, 2
L93:
	;Line no 71 FOR LOOP
	;Line no 71 expression
	;Line no 71 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 71 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L94:
	;Line no 71 expression
	;Line no 71 simple_expression with relop
	;Line no 71 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 71 CONST_INT with value 100
	MOV AX, 100
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L96
	MOV AX, 0
	JMP L97
L96:
	MOV AX, 1
L97:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L95
L98:
	;Line no 71 compound_statement
L99:
	;Line no 72 var_declaration
	SUB SP, 200
L100:
	;Line no 73 expression_statement
	;Line no 73 expression
	;Line no 73 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 73 variable assignop
	PUSH SI
	PUSH AX
	;Line no 73 CONST_INT with value 97
	MOV AX, 97
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	MOV SI, -4
	SUB SI, BX
	SUB SI, BX
	POP AX
	MOV [BP+SI], AX
	POP SI
	PUSH AX
	POP AX
L101:
	;Line no 74 expression_statement
	;Line no 74 expression
	;Line no 74 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 74 variable assignop
	PUSH SI
	PUSH AX
	;Line no 74 CONST_INT with value 98
	MOV AX, 98
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	MOV SI, -4
	SUB SI, BX
	SUB SI, BX
	POP AX
	MOV [BP+SI], AX
	POP SI
	PUSH AX
	POP AX
L102:
	;Line no 75 expression_statement
	;Line no 75 expression
	;Line no 75 variable as factor
	PUSH SI
	;Line no 75 CONST_INT with value 98
	MOV AX, 98
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	MOV SI, -4
	SUB SI, BX
	SUB SI, BX
	MOV AX, [BP+SI]
	POP SI
	PUSH AX
	;Line no 75 variable as factor
	PUSH SI
	;Line no 75 CONST_INT with value 97
	MOV AX, 97
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	MOV SI, -4
	SUB SI, BX
	SUB SI, BX
	MOV AX, [BP+SI]
	POP SI
	PUSH AX
	POP BX
	POP AX
	;Line no 75 term addition
	ADD AX, BX
	PUSH AX
	;Line no 75 CONST_INT with value 111
	MOV AX, 111
	PUSH AX
	POP BX
	POP AX
	;Line no 75 term addition
	ADD AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 75 variable assignop
	PUSH SI
	PUSH AX
	;Line no 75 CONST_INT with value 99
	MOV AX, 99
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	MOV SI, -4
	SUB SI, BX
	SUB SI, BX
	POP AX
	MOV [BP+SI], AX
	POP SI
	PUSH AX
	POP AX
L103:
	;Line no 76 IF BLOCK
	;Line no 76 simple_expression with relop
	;Line no 76 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 76 CONST_INT with value 97
	MOV AX, 97
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JE L105
	MOV AX, 0
	JMP L106
L105:
	MOV AX, 1
L106:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L104
L107:
	;Line no 76 compound_statement
L108:
	;Line no 77 var_declaration
	SUB SP, 2
L109:
	;Line no 78 expression_statement
	;Line no 78 expression
	;Line no 78 variable as factor
	PUSH SI
	;Line no 78 CONST_INT with value 99
	MOV AX, 99
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	MOV SI, -4
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
	;Line no 78 variable assignop
	MOV [BP-204], AX
	PUSH AX
	POP AX
L110:
	;Line no 79 println
	MOV AX, [BP-204]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L111:
	;Line no 80 RETURN STATEMENT
	;Line no 80 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L91
L104:
	;Line no 71 variable as factor
	;Line no 71 variable INCOP
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
	JMP L94
L95:
L112:
	;Line no 83 println
	MOV AX, [BP-2]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L91:
	MOV SP, BP
	POP BP
	RET
loop_test ENDP
	;Line no 86 func_definition
main PROC
	MOV AX, @DATA
	MOV DS, AX
	PUSH BP
	MOV BP, SP
	;Line no 86 compound_statement
L114:
	;Line no 88 var_declaration
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
L115:
	;Line no 89 expression_statement
	;Line no 89 expression
	;Line no 89 CONST_INT with value 2
	MOV AX, 2
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 89 variable assignop
	MOV [BP-4], AX
	PUSH AX
	POP AX
L116:
	;Line no 90 expression_statement
	;Line no 90 expression
	;Line no 90 CONST_INT with value 5
	MOV AX, 5
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 90 variable assignop
	MOV [BP-6], AX
	PUSH AX
	POP AX
L117:
	;Line no 91 expression_statement
	;Line no 91 expression
	;Line no 91power function call
	;Line no 91 variable as factor
	MOV AX, [BP-6]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	;Line no 91 variable as factor
	MOV AX, [BP-4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL power
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 91 variable assignop
	MOV __number, AX
	PUSH AX
	POP AX
L118:
	;Line no 92 println
	MOV AX, __number
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L119:
	;Line no 93 expression_statement
	;Line no 93 expression
	;Line no 93factorial function call
	;Line no 93 CONST_INT with value 7
	MOV AX, 7
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL factorial
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 93 variable assignop
	MOV __number, AX
	PUSH AX
	POP AX
L120:
	;Line no 94 println
	MOV AX, __number
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L121:
	;Line no 95 expression_statement
	;Line no 95 expression
	;Line no 95loop_test function call
	CALL loop_test
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
L122:
	;Line no 97 FOR LOOP
	;Line no 97 expression
	;Line no 97 CONST_INT with value 15
	MOV AX, 15
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 97 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L123:
	;Line no 97 expression
	;Line no 97 simple_expression with relop
	;Line no 97 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 97 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JGE L125
	MOV AX, 0
	JMP L126
L125:
	MOV AX, 1
L126:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L124
L127:
	;Line no 98 expression_statement
	;Line no 98 expression
	;Line no 98 CONST_INT with value 17000
	MOV AX, 17000
	PUSH AX
	POP AX
	;Line no 98 NEGATION of factor
	NEG AX
	PUSH AX
	;Line no 98 CONST_INT with value 1000
	MOV AX, 1000
	PUSH AX
	;Line no 98 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	POP BX
	POP AX
	CWD
	;Line no 98 multiplication op
	IMUL BX
	PUSH AX
	POP BX
	POP AX
	;Line no 98 term subtraction
	SUB AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 98 variable assignop
	PUSH SI
	PUSH AX
	;Line no 98 variable as factor
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
	POP AX
	MOV [SI], AX
	POP SI
	PUSH AX
	POP AX
	;Line no 97 variable as factor
	;Line no 97 variable DECOP
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
	JMP L123
L124:
L128:
	;Line no 99 expression_statement
	;Line no 99 expression
	;Line no 99 CONST_INT with value 16
	MOV AX, 16
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 99 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L129:
	;Line no 100 WHILE LOOP
L130:
	;Line no 100 variable as factor
	;Line no 100 variable DECOP
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
	CMP AX, 0
	JE L131
L132:
	;Line no 100 compound_statement
L133:
	;Line no 101 var_declaration
	SUB SP, 2
L134:
	;Line no 102 expression_statement
	;Line no 102 expression
	;Line no 102 variable as factor
	PUSH SI
	;Line no 102 CONST_INT with value 15
	MOV AX, 15
	PUSH AX
	;Line no 102 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	POP BX
	POP AX
	;Line no 102 term subtraction
	SUB AX, BX
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
	;Line no 102 variable assignop
	MOV [BP-8], AX
	PUSH AX
	POP AX
L135:
	;Line no 103 println
	MOV AX, [BP-8]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
	JMP L130
L131:
L136:
	;Line no 106 println
	MOV AX, [BP-2]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L137:
	;Line no 107 expression_statement
	;Line no 107 expression
	;Line no 107 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 107 variable assignop
	MOV [BP-4], AX
	PUSH AX
	POP AX
L138:
	;Line no 108 expression_statement
	;Line no 108 expression
	;Line no 108 CONST_INT with value 15
	MOV AX, 15
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 108 variable assignop
	MOV [BP-6], AX
	PUSH AX
	POP AX
L139:
	;Line no 109 expression_statement
	;Line no 109 expression
	;Line no 109mergeSort function call
	;Line no 109 variable as factor
	MOV AX, [BP-6]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	;Line no 109 variable as factor
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
L140:
	;Line no 111 FOR LOOP
	;Line no 111 expression
	;Line no 111 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 111 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L141:
	;Line no 111 expression
	;Line no 111 simple_expression with relop
	;Line no 111 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 111 CONST_INT with value 16
	MOV AX, 16
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L143
	MOV AX, 0
	JMP L144
L143:
	MOV AX, 1
L144:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L142
L145:
	;Line no 111 compound_statement
L146:
	;Line no 112 IF BLOCK
	;Line no 112 simple_expression with relop
	;Line no 112 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 112 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JGE L148
	MOV AX, 0
	JMP L149
L148:
	MOV AX, 1
L149:
	PUSH AX
	POP AX
	CMP AX, 0
	JNE L150
	;Line no 112 rel_expression with logicop ||
	;Line no 112__MERGE function call
	CALL __MERGE
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	CMP BX, 0
	JNE L150
	MOV AX, 0
	JMP L151
L150:
	MOV AX, 1
L151:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L147
L152:
	;Line no 112 compound_statement
L153:
	;Line no 113 expression_statement
	;Line no 113 expression
	;Line no 113 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 113 variable assignop
	MOV word2, AX
	PUSH AX
	POP AX
L154:
	;Line no 114 expression_statement
	;Line no 114 expression
	;Line no 114 CONST_INT with value 3
	MOV AX, 3
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 114 variable assignop
	MOV word2, AX
	PUSH AX
	POP AX
L155:
	;Line no 115 expression_statement
	;Line no 115 expression
	;Line no 115 variable as factor
	PUSH SI
	;Line no 115 variable as factor
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
	;Line no 115 variable assignop
	MOV word2, AX
	PUSH AX
	POP AX
L156:
	;Line no 116 println
	MOV AX, word2
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L147:
	;Line no 111 variable as factor
	;Line no 111 variable INCOP
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
	JMP L141
L142:
L157:
	;Line no 119 FOR LOOP
	;Line no 119 expression
	;Line no 119 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 119 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L158:
	;Line no 119 expression
	;Line no 119 simple_expression with relop
	;Line no 119 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 119 CONST_INT with value 16
	MOV AX, 16
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L160
	MOV AX, 0
	JMP L161
L160:
	MOV AX, 1
L161:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L159
L162:
	;Line no 120 IF BLOCK
	;Line no 120 simple_expression with relop
	;Line no 120 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 120 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L164
	MOV AX, 0
	JMP L165
L164:
	MOV AX, 1
L165:
	PUSH AX
	POP AX
	CMP AX, 0
	JE L166
	;Line no 120 rel_expression with logicop &&
	;Line no 120__MERGE function call
	CALL __MERGE
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	CMP BX, 0
	JE L166
	MOV AX, 1
	JMP L167
L166:
	MOV AX, 0
L167:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L163
L168:
	;Line no 120 compound_statement
L169:
	;Line no 121 expression_statement
	;Line no 121 expression
	;Line no 121 variable as factor
	PUSH SI
	;Line no 121 variable as factor
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
	;Line no 121 variable assignop
	MOV _j, AX
	PUSH AX
	POP AX
L170:
	;Line no 122 println
	MOV AX, _j
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L163:
	;Line no 119 variable as factor
	;Line no 119 variable INCOP
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
	JMP L158
L159:
L171:
	;Line no 125 expression_statement
	;Line no 125 expression
	;Line no 125 CONST_INT with value 200
	MOV AX, 200
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 125 variable assignop
	MOV word1, AX
	PUSH AX
	POP AX
L172:
	;Line no 126 println
	MOV AX, word1
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L173:
	;Line no 127 expression_statement
	;Line no 127 expression
	;Line no 127fibonacci function call
	;Line no 127 CONST_INT with value 23
	MOV AX, 23
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL fibonacci
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
L174:
	;Line no 128 FOR LOOP
	;Line no 128 expression
	;Line no 128 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 128 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L175:
	;Line no 128 expression
	;Line no 128 simple_expression with relop
	;Line no 128 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	;Line no 128 CONST_INT with value 24
	MOV AX, 24
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JL L177
	MOV AX, 0
	JMP L178
L177:
	MOV AX, 1
L178:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L176
L179:
	;Line no 128 compound_statement
L180:
	;Line no 129 var_declaration
	SUB SP, 2
L181:
	;Line no 130 expression_statement
	;Line no 130 expression
	;Line no 130 variable as factor
	PUSH SI
	;Line no 130 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP BX
	LEA SI, fib_mem
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
	;Line no 130 variable assignop
	MOV [BP-10], AX
	PUSH AX
	POP AX
L182:
	;Line no 131 println
	MOV AX, [BP-10]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
	;Line no 128 variable as factor
	;Line no 128 variable INCOP
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
	JMP L175
L176:
L113:
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
