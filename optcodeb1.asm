.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
.CODE
	;Line no 1 func_definition
foo PROC
	PUSH BP
	MOV BP, SP
	;Line no 1 parameter_list
	;Line no 1 compound_statement
	;Line no 2 IF BLOCK
	;Line no 2 simple_expression with relop
	;Line no 2 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 2 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	POP BX
	POP AX
	;Line no 2 term addition
	ADD AX, BX
	PUSH AX
	;Line no 2 CONST_INT with value 5
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
	;Line no 2 compound_statement
	;Line no 3 RETURN STATEMENT
	;Line no 3 CONST_INT with value 7
	MOV AX, 7
	JMP L1
L3:
	;Line no 5 RETURN STATEMENT
	;Line no 5foo function call
	;Line no 5 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	;Line no 5 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	;Line no 5 term subtraction
	SUB AX, BX
	PUSH AX
	;Line no 5 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 5 CONST_INT with value 2
	MOV AX, 2
	PUSH AX
	POP BX
	POP AX
	;Line no 5 term subtraction
	SUB AX, BX
	PUSH AX
	CALL foo
	PUSH AX
	;Line no 5 CONST_INT with value 2
	MOV AX, 2
	PUSH AX
	;Line no 5foo function call
	;Line no 5 variable as factor
	MOV AX, [BP+6]
	PUSH AX
	;Line no 5 CONST_INT with value 2
	MOV AX, 2
	PUSH AX
	POP BX
	POP AX
	;Line no 5 term subtraction
	SUB AX, BX
	PUSH AX
	;Line no 5 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 5 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	;Line no 5 term subtraction
	SUB AX, BX
	PUSH AX
	CALL foo
	PUSH AX
	POP BX
	POP AX
	CWD
	;Line no 5 multiplication op
	IMUL BX
	PUSH AX
	POP BX
	POP AX
	;Line no 5 term addition
	ADD AX, BX
	JMP L1
L1:
	MOV SP, BP
	POP BP
	RET 4
foo ENDP
	;Line no 9 func_definition
main PROC
	MOV AX, @DATA
	MOV DS, AX
	PUSH BP
	MOV BP, SP
	;Line no 9 compound_statement
	;Line no 10 var_declaration
	SUB SP, 2
	SUB SP, 2
	SUB SP, 2
	;Line no 11 expression_statement
	;Line no 11 expression
	;Line no 11 CONST_INT with value 7
	MOV AX, 7
	;Line no 11 variable assignop
	MOV [BP-2], AX
	;Line no 12 expression_statement
	;Line no 12 expression
	;Line no 12 CONST_INT with value 3
	MOV AX, 3
	;Line no 12 variable assignop
	MOV [BP-4], AX
	;Line no 14 expression_statement
	;Line no 14 expression
	;Line no 14foo function call
	;Line no 14 variable as factor
	MOV AX, [BP-4]
	PUSH AX
	;Line no 14 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	CALL foo
	;Line no 14 variable assignop
	MOV [BP-6], AX
	;Line no 15 println
	MOV AX, [BP-6]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
	;Line no 17 RETURN STATEMENT
	;Line no 17 CONST_INT with value 0
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
