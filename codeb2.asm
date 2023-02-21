.MODEL SMALL
.STACK 1000H
.DATA
	CR EQU 0DH
	LF EQU 0AH
	number DB "00000$"
.CODE
	;Line no 1 func_definition
func PROC
	PUSH BP
	MOV BP, SP
	;Line no 1 parameter_list
	;Line no 1 compound_statement
L2:
	;Line no 2 var_declaration
	SUB SP, 2
L3:
	;Line no 3 IF BLOCK
	;Line no 3 simple_expression with relop
	;Line no 3 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 3 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JE L5
	MOV AX, 0
	JMP L6
L5:
	MOV AX, 1
L6:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L4
L7:
	;Line no 3 RETURN STATEMENT
	;Line no 3 CONST_INT with value 0
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
L4:
L8:
	;Line no 4 expression_statement
	;Line no 4 expression
	;Line no 4 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 4 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L9:
	;Line no 5 RETURN STATEMENT
	;Line no 5func function call
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
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL func
	PUSH AX
	;Line no 5 variable as factor
	MOV AX, [BP-2]
	PUSH AX
	POP BX
	POP AX
	;Line no 5 term addition
	ADD AX, BX
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
func ENDP
	;Line no 8 func_definition
func2 PROC
	PUSH BP
	MOV BP, SP
	;Line no 8 parameter_list
	;Line no 8 compound_statement
L11:
	;Line no 9 var_declaration
	SUB SP, 2
L12:
	;Line no 10 IF BLOCK
	;Line no 10 simple_expression with relop
	;Line no 10 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 10 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP BX
	POP AX
	CMP AX, BX
	JE L14
	MOV AX, 0
	JMP L15
L14:
	MOV AX, 1
L15:
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	CMP AX, 0
	JE L13
L16:
	;Line no 10 RETURN STATEMENT
	;Line no 10 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L10
L13:
L17:
	;Line no 11 expression_statement
	;Line no 11 expression
	;Line no 11 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 11 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L18:
	;Line no 12 RETURN STATEMENT
	;Line no 12func function call
	;Line no 12 variable as factor
	MOV AX, [BP+4]
	PUSH AX
	;Line no 12 CONST_INT with value 1
	MOV AX, 1
	PUSH AX
	POP BX
	POP AX
	;Line no 12 term subtraction
	SUB AX, BX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL func
	PUSH AX
	;Line no 12 variable as factor
	MOV AX, [BP-2]
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
	JMP L10
L10:
	MOV SP, BP
	POP BP
	RET 2
func2 ENDP
	;Line no 15 func_definition
main PROC
	MOV AX, @DATA
	MOV DS, AX
	PUSH BP
	MOV BP, SP
	;Line no 15 compound_statement
L20:
	;Line no 16 var_declaration
	SUB SP, 2
L21:
	;Line no 17 expression_statement
	;Line no 17 expression
	;Line no 17func function call
	;Line no 17 CONST_INT with value 7
	MOV AX, 7
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	CALL func
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	;Line no 17 variable assignop
	MOV [BP-2], AX
	PUSH AX
	POP AX
L22:
	;Line no 18 println
	MOV AX, [BP-2]
	CALL PRINT_OUTPUT
	CALL NEW_LINE
L23:
	;Line no 19 RETURN STATEMENT
	;Line no 19 CONST_INT with value 0
	MOV AX, 0
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	PUSH AX
	POP AX
	JMP L19
L19:
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
