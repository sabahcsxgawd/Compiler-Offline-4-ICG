.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
	c DW 1 DUP (0000H)
	a DW 1 DUP (0000H)
	b DW 1 DUP (0000H)
.CODE
	;Line no 1 var_declaration
	;Line no 3 func_definition
func_a PROC
	PUSH BP
	MOV BP, SP
	;Line no 4 compound_statement
L2:
	;Line no 5 expression_statement
	;Line no 5 expression
	;Line no 5 CONST_INT with value 7
	MOV AX, 7
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 5 variable assignop
	MOV a, AX
	PUSH AX
	POP AX
L1:
	MOV SP, BP
	POP BP
	RET
func_a ENDP
	;Line no 8 func_definition
foo PROC
	PUSH BP
	MOV BP, SP
	;Line no 8 parameter_list
	;Line no 9 compound_statement
L4:
	;Line no 10 expression_statement
	;Line no 10 expression
	;Line no 10 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 10 CONST_INT with value 3
	MOV AX, 3
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
	MOV [BP+4], AX
	PUSH AX
	POP AX
L5:
	;Line no 11 RETURN STATEMENT
	;Line no 11 variable as factor
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
	;Line no 14 func_definition
bar PROC
	PUSH BP
	MOV BP, SP
	;Line no 14 parameter_list
	;Line no 15 compound_statement
L7:
	;Line no 16 expression_statement
	;Line no 16 expression
	;Line no 16 CONST_INT with value 4
	MOV AX, 4
	PUSH AX
	;Line no 16 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP BX
	POP AX
	CWD
	;Line no 16 multiplication op
	IMUL BX
	PUSH AX
	;Line no 16 CONST_INT with value 2
	MOV AX, 2
	PUSH AX
	;Line no 16 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	POP BX
	POP AX
	CWD
	;Line no 16 multiplication op
	IMUL BX
	PUSH AX
	POP BX
	POP AX
	;Line no 16 term addition
	ADD AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 16 variable assignop
	MOV c, AX
	PUSH AX
	POP AX
L8:
	;Line no 17 RETURN STATEMENT
	;Line no 17 variable as factor
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
	;Line no 20 func_definition
main PROC
	MOV AX, @DATA
	MOV DS, AX
	PUSH BP
	MOV BP, SP
	;Line no 21 compound_statement
L10:
	;Line no 23 var_declaration
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
L11:
	;Line no 25 expression_statement
	;Line no 25 expression
	;Line no 25 CONST_INT with value 5
	MOV AX, 5
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 25 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L12:
	;Line no 26 expression_statement
	;Line no 26 expression
	;Line no 26 CONST_INT with value 6
	MOV AX, 6
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 26 variable assignop
	MOV [BP-4], AX
	PUSH AX
	POP AX
L13:
	;Line no 28 expression_statement
	;Line no 28 expression
	;Line no 28func_a function call
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
	;Line no 29 println
	MOV AX, a
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L15:
	;Line no 31 expression_statement
	;Line no 31 expression
	;Line no 31foo function call
	;Line no 31 variable as factor
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
	;Line no 31 variable assignop
	MOV [BP-6], AX
	PUSH AX
	POP AX
L16:
	;Line no 32 println
	MOV AX, [BP-6]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L17:
	;Line no 34 expression_statement
	;Line no 34 expression
	;Line no 34bar function call
	;Line no 34 variable as factor
	MOV AX, [BP-4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	;Line no 34 variable as factor
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
	;Line no 34 variable assignop
	MOV [BP-8], AX
	PUSH AX
	POP AX
L18:
	;Line no 35 println
	MOV AX, [BP-8]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L19:
	;Line no 37 expression_statement
	;Line no 37 expression
	;Line no 37 CONST_INT with value 6
	MOV AX, 6
	PUSH AX
	;Line no 37bar function call
	;Line no 37 variable as factor
	MOV AX, [BP-4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	;Line no 37 variable as factor
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
	;Line no 37 multiplication op
	IMUL BX
	PUSH AX
	;Line no 37 CONST_INT with value 2
	MOV AX, 2
	PUSH AX
	POP BX
	POP AX
	;Line no 37 term addition
	ADD AX, BX
	PUSH AX
	;Line no 37 CONST_INT with value 3
	MOV AX, 3
	PUSH AX
	;Line no 37foo function call
	;Line no 37 variable as factor
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
	;Line no 37 multiplication op
	IMUL BX
	PUSH AX
	POP BX
	POP AX
	;Line no 37 term subtraction
	SUB AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 37 variable assignop
	MOV [BP-4], AX
	PUSH AX
	POP AX
L20:
	;Line no 38 println
	MOV AX, [BP-4]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L21:
	;Line no 40 RETURN STATEMENT
	;Line no 40 CONST_INT with value 0
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
