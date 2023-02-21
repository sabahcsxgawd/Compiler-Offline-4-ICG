%{
#include <bits/stdc++.h>
using namespace std;

#include "1905118_symbol_table.h"
#include "optimizer.h"

int yyparse(void);
int yylex(void);
extern FILE *yyin;

ofstream logOut, errorOut, parseTree, codeasm, optcodeasm;
ifstream unoptcodeasm;

int lineCount = 1, errorCount = 0, errorLine = 0, offsetForVar = 0, anotherOffset = 0, labelCount = 0;

bool isFunctionScope = false, isZeroVal = false, isError = false, doIncop = false, doDecop = false;

vector<SymbolInfo*> functionParameterList, variableDeclarationList;

uint64_t num_of_buckets = 11, scopeTableCounter = 1;

SymbolTable *symbolTable = new SymbolTable();

SymbolInfo *startSymbol, *func_def_test;

// map< pair<string, int>, SymbolInfo * > symbolMap;

string globalLabel = "";

string new_line_proc = "\n\
NEW_LINE PROC\n\
	PUSH AX\n\
	PUSH DX\n\
	MOV AH, 2\n\
	MOV DL, CR\n\
	INT 21H\n\
	MOV AH, 2\n\
	MOV DL, LF\n\
	INT 21H\n\
	POP DX\n\
	POP AX\n\
	RET\n\
NEW_LINE ENDP\n\n";

string print_output_proc = "\n\
PRINT_OUTPUT PROC  ;PRINT WHAT IS IN AX\n\
	PUSH AX\n\
	PUSH BX\n\
	PUSH CX\n\
	PUSH DX\n\
	PUSH SI\n\
	LEA SI, NUMBER\n\
	MOV BX, 10\n\
	ADD SI, 4\n\
	CMP AX, 0\n\
	JNGE NEGATE\n\
PRINT:\n\
	XOR DX, DX\n\
	DIV BX\n\
	MOV [SI], DL\n\
	ADD [SI], '0'\n\
	DEC SI\n\
	CMP AX, 0\n\
	JNE PRINT\n\
	INC SI\n\
	LEA DX, SI\n\
	MOV AH, 9\n\
	INT 21H\n\
	POP SI\n\
	POP DX\n\
	POP CX\n\
	POP BX\n\
	POP AX\n\
	RET\n\
NEGATE:\n\
	PUSH AX\n\
	MOV AH, 2\n\
	MOV DL, '-'\n\
	INT 21H\n\
	POP AX\n\
	NEG AX\n\
	JMP PRINT\n\
PRINT_OUTPUT ENDP\n";

void yyerror(char *s)
{
	//write your code
}

void deleteParseTree(SymbolInfo *head) {
	if(head != NULL) {
		vector<SymbolInfo*> tempHeadParseTreeChildList = head->getParseTreeChildList();
		for(int i = 0; i < tempHeadParseTreeChildList.size(); i++) {
			deleteParseTree(tempHeadParseTreeChildList[i]); 
		}
		delete head;
	}
}

string printWhiteSpace(int whiteSpaceCount) {
	string ws = "";
	for(int i = 0; i < whiteSpaceCount; i++) {
		ws += ' ';
	}
	return ws;
}

string printRuleStartEndLine(SymbolInfo *symbolInfo) {
	string start = to_string(symbolInfo->getRuleStartLine());
	string end = to_string(symbolInfo->getRuleEndLine());
	bool isLeaf = symbolInfo->getLeafNodeStatus();
	string lineNonLeaf = " 	<Line: " + start + "-" + end + ">\n";
	string lineLeaf = "	<Line: " + start + ">\n";
	if(isLeaf) {
		return lineLeaf;
	}
	return lineNonLeaf;
}

void printParseTree(SymbolInfo *head, int whiteSpaceCount) {
	if(head != NULL) {
		parseTree << printWhiteSpace(whiteSpaceCount) << head->getType() << " : " << head->getName() << printRuleStartEndLine(head);
		vector<SymbolInfo*> tempHeadParseTreeChildList = head->getParseTreeChildList();
		for(int i = 0; i < tempHeadParseTreeChildList.size(); i++) {
			printParseTree(tempHeadParseTreeChildList[i], whiteSpaceCount + 1);
		}
	}
}

void tryToDefineFunction(SymbolInfo *s, string type_specifier) {
	SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable(s->getName());
	if(finder == NULL) {
		s->setDataType(type_specifier);
		s->setIsAFunction(true);
		s->setIsFunctionDefined(true);
		for(SymbolInfo* ss : functionParameterList) {
			s->addFunctionParameterToList(ss);
		}
		SymbolInfo *s_temp = new SymbolInfo(s);
		symbolTable->insertSymbolInSymbolTable(s_temp, logOut);
		// symbolMap.insert(make_pair(make_pair(s->getName(), scopeTableCounter), s));
	}
	else {
		if(!(finder->getIsAFunction())) {
			// TODO redeclared as different kind of symbol
			errorOut << "Line# " << lineCount << ": '" << finder->getName() << "' redeclared as different kind of symbol\n";
			errorCount++;
		}
		else if(finder->getIsFunctionDefined()) {
			// TODO func already defined
			errorCount++;
			errorOut << "Line# " << lineCount << ": Redefinition of function '" << finder->getName() << "'" << '\n';
		}
		else if(finder->getIsFunctionDeclared()) {
			if(finder->getDataType() == type_specifier) {
			vector<SymbolInfo *> v1, v2;
			v1 = finder->getFunctionParameterList();
			v2 = functionParameterList;
				if(v1.size() == v2.size()) {
					bool isGood = true;
					for(int i = 0; i < v1.size(); i++) {
						if(v1[i]->getDataType() != v2[i]->getDataType()) {
							isGood = false;
							// TODO Type mismatch for argument 1 of 'func'
							// errorOut << "Line# " << lineCount << ": Type mismatch for argument " << i+1 << " of '" << finder->getName() << "'" << '\n';
							// errorCount++;
							break;
						}
					}
					if(isGood) {
						finder->setIsFunctionDefined(true);
					}
					else {
						// TODO conflicting type and maybe redefined error	
						// errorOut << "Line# " << lineCount << ": Conflicting types for '" << finder->getName() << "'" << '\n';
						// errorCount++;								
					}
				}
				else {
					// TODO Too few arguments to function
					// if(v1.size() > v2.size()) {
					// 	errorCount++;
					// 	errorOut << "Line# " << lineCount << ": Too few arguments to function '" << finder->getName() << "'" << '\n';
					// }
					// else {
					// 	errorCount++;
					// 	errorOut << "Line# " << lineCount << ": Too many arguments to function '" << finder->getName() << "'" << '\n';
					// }
					errorOut << "Line# " << lineCount << ": Conflicting types for '" << finder->getName() << "'" << '\n';
					errorCount++;	
				}
			}
			else {
				//TODO Conflicting types
				errorOut << "Line# " << lineCount << ": Conflicting types for '" << finder->getName() << "'" << '\n';
				errorCount++;
			}
		}
		// else if(!(finder->getIsFunctionDeclared())) {
		// 	finder->setIsFunctionDefined(true);
		// }
		else {
			//TODO redecl error
		}
		
	}	
}

void tryToInsertParamsInSymbolTable() {
	for(SymbolInfo* s : functionParameterList) {
		// cout << s->getName() << " pppppppppp " << s << '\n';
		if(s->getName() == "" && s->getType() == "") {
			// TODO param is IDless error in func def
		}
		else {
			SymbolInfo *s_temp = new SymbolInfo(s);
			if(!(symbolTable->insertSymbolInSymbolTable(s_temp, logOut))) {
				// TODO redef of parameter
				errorCount++;
				errorOut << "Line# " << lineCount - 1 << ": Redefinition of parameter '" << s_temp->getName() << "'" << '\n';
				delete s_temp;
			}
			// else {
			// 	// cout << s->getName() << " GGGGGGGG " << s << ' ' << scopeTableCounter << '\n';
			// 	symbolMap.insert(make_pair(make_pair(s->getName(), scopeTableCounter), s));
			// }
		}
	}
}

void printAboutVarInASM(SymbolInfo *var, int varSize) {
	string varName = var->getName();
	var->baseOffset = offsetForVar - 2;
	offsetForVar = offsetForVar - (2 * varSize);
	codeasm << "\tSUB SP, " << (2 * varSize) << '\n';
}

string genLabel() {
	return "L" + to_string(++labelCount);
}


%}

%union {
	SymbolInfo* symbolInfo;
}

%token <symbolInfo> IF ELSE FOR DO WHILE BREAK INT CHAR FLOAT DOUBLE VOID RETURN SWITCH CASE CONTINUE DEFAULT PRNTLN
%token <symbolInfo> CONST_INT CONST_FLOAT ID ADDOP MULOP INCOP DECOP RELOP ASSIGNOP BITOP LOGICOP NOT LPAREN RPAREN LCURL RCURL LSQUARE RSQUARE COMMA SEMICOLON
%type <symbolInfo> start program unit var_declaration func_declaration func_definition type_specifier parameter_list compound_statement
%type <symbolInfo> statement statements declaration_list expression expression_statement variable logic_expression rel_expression simple_expression term
%type <symbolInfo> unary_expression factor argument_list arguments

%start start

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE


%%

start : program
	{
		//write your code in this block in all the similar blocks below
		logOut << "start : program" << '\n';
		$$ = new SymbolInfo("program", "start");
		$$->setRuleStartLine($1->getRuleStartLine());
        $$->setRuleEndLine($1->getRuleEndLine());
        $$->setLeafNodeStatus(false);
		$$->addSymbolToList($1);
		printParseTree($$, 0);
		// deleteParseTree($$);
		startSymbol = $$;
	}
	;

program : program unit {
		logOut << "program : program unit " << '\n';
		$$ = new SymbolInfo("program unit", "program");
		$$->setRuleStartLine($1->getRuleStartLine());
        $$->setRuleEndLine($2->getRuleEndLine());
        $$->setLeafNodeStatus(false);
		$$->addSymbolToList($1);
		$$->addSymbolToList($2);
	}
	| unit {
		logOut << "program : unit " << '\n';
		$$ = new SymbolInfo("unit", "program");
		$$->setRuleStartLine($1->getRuleStartLine());
        $$->setRuleEndLine($1->getRuleEndLine());
        $$->setLeafNodeStatus(false);
		$$->addSymbolToList($1);
	}
	;
	
unit : var_declaration {
		logOut << "unit : var_declaration" << '\n';
		$$ = new SymbolInfo("var_declaration", "unit");
		$$->setRuleStartLine($1->getRuleStartLine());
        $$->setRuleEndLine($1->getRuleEndLine());
        $$->setLeafNodeStatus(false);
		$$->addSymbolToList($1);
	}
     | func_declaration {
		logOut << "unit : func_declaration" << '\n';
		$$ = new SymbolInfo("func_declaration", "unit");
		$$->setRuleStartLine($1->getRuleStartLine());
        $$->setRuleEndLine($1->getRuleEndLine());
        $$->setLeafNodeStatus(false);
		$$->addSymbolToList($1);

	 }
     | func_definition {
		logOut << "unit : func_definition" << '\n';
		$$ = new SymbolInfo("func_definition", "unit");
		$$->setRuleStartLine($1->getRuleStartLine());
        $$->setRuleEndLine($1->getRuleEndLine());
        $$->setLeafNodeStatus(false);
		$$->addSymbolToList($1);
	 }
     ; 
     
func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON {
					isFunctionScope = false;
					logOut << "func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON" << '\n';
					$$ = new SymbolInfo("type_specifier ID LPAREN parameter_list RPAREN SEMICOLON", "func_declaration");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($6->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);
					$$->addSymbolToList($4);
					$$->addSymbolToList($5);
					$$->addSymbolToList($6);

					SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable($2->getName());
					if(finder == NULL) {
						$2->setDataType($1->getName());
						$2->setIsAFunction(true);
						$2->setIsFunctionDeclared(true);
						for(SymbolInfo* s : functionParameterList) {
							$2->addFunctionParameterToList(s);
						}
						SymbolInfo *s_temp = new SymbolInfo($2);
						symbolTable->insertSymbolInSymbolTable(s_temp, logOut);
						// symbolMap.insert(make_pair(make_pair($2->getName(), scopeTableCounter), $2));
					}
					else {
						$2->setDataType($1->getName());
						if(!(finder->getIsAFunction())) {
							// TODO redeclared as different kind of symbol
							errorOut << "Line# " << lineCount << ": '" << finder->getName() << "' redeclared as different kind of symbol\n";
							errorCount++;
						}
						else if(finder->getIsFunctionDeclared()) {
							// TODO func already defined
							// errorOut << "Line# " << lineCount << ": Conflicting types for '" << finder->getName() << "'" << '\n';
							// errorCount++;
						}
						else if(finder->getDataType() == $2->getDataType()) {
							vector<SymbolInfo *> v1, v2;
							v1 = finder->getFunctionParameterList();
							v2 = $2->getFunctionParameterList();
							if(v1.size() == v2.size()) {
								bool isGood = true;
								for(int i = 0; i < v1.size(); i++) {
									if(v1[i]->getDataType() != v2[i]->getDataType()) {
										isGood = false;
										// TODO Type mismatch for argument 1 of 'func'
										errorOut << "Line# " << lineCount << ": Type mismatch for argument " << i+1 << " of '" << finder->getName() << "'" << '\n';
										errorCount++;
										// break;
									}
								}
								if(isGood) {
									finder->setIsFunctionDeclared(true);
								}
								else {
									// TODO conflicting type and maybe redefined error									
								}
							}
							else {
								// TODO Too few arguments to function
								if(v1.size() > v2.size()) {
									errorCount++;
									errorOut << "Line# " << lineCount << ": Too few arguments to function '" << finder->getName() << "'" << '\n';
								}
								else {
									errorCount++;
									errorOut << "Line# " << lineCount << ": Too many arguments to function '" << finder->getName() << "'" << '\n';
								}
							}
						}
						else {
							//TODO redecl error
						}
					}	
					functionParameterList.clear();
				 }
				 | type_specifier ID LPAREN RPAREN SEMICOLON {
					isFunctionScope = false;
					logOut << "func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON" << '\n';
					$$ = new SymbolInfo("type_specifier ID LPAREN RPAREN SEMICOLON", "func_declaration");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($5->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);
					$$->addSymbolToList($4);
					$$->addSymbolToList($5);

					SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable($2->getName());
					if(finder == NULL) {
						$2->setDataType($1->getName());
						$2->setIsAFunction(true);
						$2->setIsFunctionDeclared(true);					
						SymbolInfo *s_temp = new SymbolInfo($2);
						symbolTable->insertSymbolInSymbolTable(s_temp, logOut);
						// symbolMap.insert(make_pair(make_pair($1->getName(), scopeTableCounter), $1));
					}
					else {
						if(!(finder->getIsAFunction())) {
							// TODO redeclared as different kind of symbol
							errorOut << "Line# " << lineCount << ": '" << finder->getName() << "' redeclared as different kind of symbol\n";
							errorCount++;
						}
						else if(finder->getIsFunctionDeclared()) {
							// TODO func already defined
							// errorOut << "Line# " << lineCount << ": Conflicting types for '" << finder->getName() << "'" << '\n';
							// errorCount++;
						}
						else if(finder->getDataType() == $2->getDataType()) {
							vector<SymbolInfo *> v1, v2;
							v1 = finder->getFunctionParameterList();
							v2 = $2->getFunctionParameterList();
							if(v1.size() == v2.size()) {
								finder->setIsFunctionDeclared(true);
							}
							else {
								// TODO Too few arguments to function
								if(v1.size() > v2.size()) {
									errorCount++;
									errorOut << "Line# " << lineCount << ": Too few arguments to function '" << finder->getName() << "'" << '\n';
								}
								else {
									errorCount++;
									errorOut << "Line# " << lineCount << ": Too many arguments to function '" << finder->getName() << "'" << '\n';
								}
							}
						}
						else {
							//TODO redecl error
						}
					}	
					functionParameterList.clear();
				 }
				 ;
		 
func_definition : type_specifier ID LPAREN parameter_list RPAREN {
					tryToDefineFunction($2, $1->getName());
					isFunctionScope = true;
				} compound_statement {
					logOut << "func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement" << '\n';
					$$ = new SymbolInfo("type_specifier ID LPAREN parameter_list RPAREN compound_statement", "func_definition");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($7->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);
					$$->addSymbolToList($4);
					$$->addSymbolToList($5);
					$$->addSymbolToList($7);

					functionParameterList.clear();
					isFunctionScope = false;
				}
				| type_specifier ID LPAREN RPAREN {
					tryToDefineFunction($2, $1->getName());
					isFunctionScope = true;
				} compound_statement {
					logOut << "func_definition : type_specifier ID LPAREN RPAREN compound_statement" << '\n';
					$$ = new SymbolInfo("type_specifier ID LPAREN RPAREN compound_statement", "func_definition");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($6->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);
					$$->addSymbolToList($4);
					$$->addSymbolToList($6);

					functionParameterList.clear();
					isFunctionScope = false;				
				}
				| type_specifier ID LPAREN error {
					if(errorLine == 0 | isError) {
						errorCount++;
						errorOut << "Line# " << lineCount << ": Syntax error at parameter list of function definition\n";
						logOut << "Error at line no " << lineCount << " : syntax error\n";
						functionParameterList.clear();
						// isError = false;
						errorLine = lineCount;
					} } RPAREN {
						isError = false;
						errorLine = 0;
					} compound_statement {
						logOut << "func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement" << '\n';
						$$ = new SymbolInfo("type_specifier ID LPAREN parameter_list RPAREN compound_statement", "func_definition");
						$$->setRuleStartLine($1->getRuleStartLine());
						$$->setRuleEndLine($8->getRuleEndLine());
						$$->setLeafNodeStatus(false);
						$$->addSymbolToList($1);
						$$->addSymbolToList($2);
						$$->addSymbolToList($3);
						SymbolInfo *s_temp = new SymbolInfo("error", "parameter_list");
						s_temp->setRuleStartLine($3->getRuleStartLine());
						s_temp->setRuleEndLine($6->getRuleEndLine());
						s_temp->setLeafNodeStatus(true);
						$$->addSymbolToList(s_temp);
						$$->addSymbolToList($6);
						$$->addSymbolToList($8);

						functionParameterList.clear();
						isFunctionScope = false;
						isError = false;
						errorLine = 0;						
				}
				;				


parameter_list  : parameter_list COMMA type_specifier ID {
					logOut << "parameter_list  : parameter_list COMMA type_specifier ID" << '\n';
					$$ = new SymbolInfo("parameter_list COMMA type_specifier ID", "parameter_list");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($4->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);
					$$->addSymbolToList($4);

					//need to set data type of ID
					$4->setDataType($3->getName());
					functionParameterList.push_back($4);
				}
				| parameter_list COMMA type_specifier {
					logOut << "parameter_list : parameter_list COMMA type_specifier" << '\n';
					$$ = new SymbolInfo("parameter_list COMMA type_specifier", "parameter_list");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($3->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);

					//need to set data type of ID
					SymbolInfo *tempSymbol = new SymbolInfo("", "");
					tempSymbol->setDataType($3->getName());
					functionParameterList.push_back(tempSymbol);
				}
 				| type_specifier ID {
					logOut << "parameter_list  : type_specifier ID" << '\n';
					$$ = new SymbolInfo("type_specifier ID", "parameter_list");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($2->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);

					//need to set data type of ID
					$2->setDataType($1->getName());
					functionParameterList.push_back($2);
				}
				| type_specifier {
					logOut << "parameter_list : type_specifier" << '\n';
					$$ = new SymbolInfo("type_specifier", "parameter_list");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);

					//need to set data type of ID
					SymbolInfo *tempSymbol = new SymbolInfo("", "");
					tempSymbol->setDataType($1->getName());
					functionParameterList.push_back(tempSymbol);
				}
 				;

 		
compound_statement : LCURL {						
						symbolTable->enterScope(scopeTableCounter++, num_of_buckets);
						if(isFunctionScope) {
							tryToInsertParamsInSymbolTable();
							functionParameterList.clear();
						}
					} statements RCURL {
						logOut << "compound_statement : LCURL statements RCURL" << '\n';
						$$ = new SymbolInfo("LCURL statements RCURL", "compound_statement");
						$$->setRuleStartLine($1->getRuleStartLine());
						$$->setRuleEndLine($4->getRuleEndLine());
						$$->setLeafNodeStatus(false);
						$$->addSymbolToList($1);
						$$->addSymbolToList($3);
						$$->addSymbolToList($4);

						symbolTable->printAllScopeTables(logOut);
						symbolTable->exitScope();
						// scopeTableCounter--;
				   }
 		    	   | LCURL {						
						symbolTable->enterScope(scopeTableCounter++, num_of_buckets);
						if(isFunctionScope) {
							tryToInsertParamsInSymbolTable();
							functionParameterList.clear();
						}
				   } RCURL {
						logOut << "compound_statement : LCURL RCURL" << '\n';
						$$ = new SymbolInfo("LCURL RCURL", "compound_statement");
						$$->setRuleStartLine($1->getRuleStartLine());
						$$->setRuleEndLine($3->getRuleEndLine());
						$$->setLeafNodeStatus(false);
						$$->addSymbolToList($1);
						$$->addSymbolToList($3);

						symbolTable->printAllScopeTables(logOut);
						symbolTable->exitScope();
						// scopeTableCounter--;
				   }
 		    	   ;
 		    
var_declaration : type_specifier declaration_list SEMICOLON {
					logOut << "var_declaration : type_specifier declaration_list SEMICOLON" << '\n';
					$$ = new SymbolInfo("type_specifier declaration_list SEMICOLON", "var_declaration");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($3->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);
					

					if($1->getName() == "VOID") {
						// TODO throw error that var cant be void type

						for(SymbolInfo *s : variableDeclarationList) {
							errorCount++;
							errorOut << "Line# " << lineCount << ": Variable or field '" << s->getName() << "' declared void\n";
						}		
					}

					else {
						// need to add the declared vars in an a list and set their type
						for(SymbolInfo *s : variableDeclarationList) {
							s->setDataType($1->getName());
							SymbolInfo *s_temp = new SymbolInfo(s);
							if(!(symbolTable->insertSymbolInSymbolTable(s_temp, logOut))) {
								// TODO print var redecl error
								errorCount++;
								SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable(s_temp->getName());
								if(finder->getDataType() != s_temp->getDataType()) {
									errorOut << "Line# " << lineCount << ": Conflicting types for'" << s_temp->getName() << "'" << '\n';
								}
								else {
									errorOut << "Line# " << lineCount << ": Redeclaration of variable '" << s_temp->getName() << "'" << '\n';
								}
								delete s_temp;
							}
							// else {
							// 	symbolMap.insert(make_pair(make_pair(s->getName(), scopeTableCounter), s));
							// }
						}
					}

					variableDeclarationList.clear();
				}
				| type_specifier error {
					if(isError) {
						// errorLine = lineCount;
						// errorOut << "Line# " << lineCount << ": Syntax error at declaration list of variable declaration\n";
						logOut << "Error at line no " << lineCount << " : syntax error\n";
					} } SEMICOLON {
						logOut << "var_declaration : type_specifier declaration_list SEMICOLON" << '\n';
						errorOut << "Line# " << lineCount << ": Syntax error at declaration list of variable declaration\n";
						errorCount++;
						$$ = new SymbolInfo("type_specifier declaration_list SEMICOLON", "var_declaration");
						$$->setRuleStartLine($1->getRuleStartLine());
						$$->setRuleEndLine($4->getRuleEndLine());
						$$->setLeafNodeStatus(false);
						$$->addSymbolToList($1);
						SymbolInfo *s_temp = new SymbolInfo("error", "declaration_list");
						s_temp->setLeafNodeStatus(true);
						s_temp->setRuleStartLine(lineCount);
						s_temp->setRuleEndLine(lineCount);
						$$->addSymbolToList(s_temp);
						$$->addSymbolToList($4);

						variableDeclarationList.clear();
						isError = false;
						errorLine = 0;
				}
				;
 		 
type_specifier	: INT {
					logOut << "type_specifier	: INT" << '\n';
					$$ = new SymbolInfo("INT", "type_specifier");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
				}
 				| FLOAT {
					logOut << "type_specifier	: FLOAT" << '\n';
					$$ = new SymbolInfo("FLOAT", "type_specifier");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
				}
 				| VOID {
					logOut << "type_specifier	: VOID" << '\n';
					$$ = new SymbolInfo("VOID", "type_specifier");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
				}
 				;
 		
declaration_list : declaration_list COMMA ID {
					logOut << "declaration_list : declaration_list COMMA ID" << '\n';
					$$ = new SymbolInfo("declaration_list COMMA ID", "declaration_list");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($3->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);

					variableDeclarationList.push_back($3);


				}
 		  		 | declaration_list COMMA ID LSQUARE CONST_INT RSQUARE {
					logOut << "declaration_list : declaration_list COMMA ID LSQUARE CONST_INT RSQUARE" << '\n';
					$$ = new SymbolInfo("declaration_list COMMA ID LSQUARE CONST_INT RSQUARE", "declaration_list");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($6->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);
					$$->addSymbolToList($4);
					$$->addSymbolToList($5);
					$$->addSymbolToList($6);

					$3->setIsAnArray(true);
					$3->setArraySize(stoi($5->getName()));
					variableDeclarationList.push_back($3);
				 }
 		  		 | ID {
					logOut << "declaration_list : ID" << '\n';
					$$ = new SymbolInfo("ID", "declaration_list");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					// cout << $1->getName() << " global " << $1 << '\n';
					variableDeclarationList.push_back($1);
				 }
 		  		 | ID LSQUARE CONST_INT RSQUARE {
					logOut << "declaration_list : ID LSQUARE CONST_INT RSQUARE" << '\n';
					$$ = new SymbolInfo("ID LSQUARE CONST_INT RSQUARE", "declaration_list");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($4->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);
					$$->addSymbolToList($4);

					$1->setIsAnArray(true);
					$1->setArraySize(stoi($3->getName()));
					variableDeclarationList.push_back($1);
				 }
 		  		 ;
 		  
statements : statement {
					logOut << "statements : statement" << '\n';
					$$ = new SymbolInfo("statement", "statements");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
			}
	   	   | statements statement {
					logOut << "statements : statements statement" << '\n';
					$$ = new SymbolInfo("statements statement", "statements");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($2->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
		   }
	   	   ;
	   
	   // TODO func inside func error
statement : var_declaration {
					logOut << "statement : var_declaration" << '\n';
                    $$ = new SymbolInfo("var_declaration", "statement");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
		  }
	  	  | expression_statement {
					logOut << "statement : expression_statement" << '\n';
                    $$ = new SymbolInfo("expression_statement", "statement");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
		  }
	  	  | compound_statement {
					logOut << "statement : compound_statement" << '\n';
                    $$ = new SymbolInfo("compound_statement", "statement");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
		  }
	  	  | FOR LPAREN expression_statement expression_statement expression RPAREN statement {
					logOut << "statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement" << '\n';
                    $$ = new SymbolInfo("FOR LPAREN expression_statement expression_statement expression RPAREN statement", "statement");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($7->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);
					$$->addSymbolToList($4);
					$$->addSymbolToList($5);
					$$->addSymbolToList($6);
					$$->addSymbolToList($7);
		  }
	  	  | IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE {
					logOut << "statement : IF LPAREN expression RPAREN statement" << '\n';
                    $$ = new SymbolInfo("IF LPAREN expression RPAREN statement", "statement");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($5->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);
					$$->addSymbolToList($4);
					$$->addSymbolToList($5);
		  }
	  	  | IF LPAREN expression RPAREN statement ELSE statement {
					logOut << "statement : IF LPAREN expression RPAREN statement ELSE statement" << '\n';
                    $$ = new SymbolInfo("IF LPAREN expression RPAREN statement ELSE statement", "statement");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($7->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);
					$$->addSymbolToList($4);
					$$->addSymbolToList($5);
					$$->addSymbolToList($6);
					$$->addSymbolToList($7);
		  }
	  	  | WHILE LPAREN expression RPAREN statement {
					logOut << "statement : WHILE LPAREN expression RPAREN statement" << '\n';
                    $$ = new SymbolInfo("WHILE LPAREN expression RPAREN statement", "statement");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($5->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);
					$$->addSymbolToList($4);
					$$->addSymbolToList($5);
		  }
	  	  | PRNTLN LPAREN ID RPAREN SEMICOLON {
					logOut << "statement : PRNTLN LPAREN ID RPAREN SEMICOLON" << '\n';
                    $$ = new SymbolInfo("PRNTLN LPAREN ID RPAREN SEMICOLON", "statement");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($5->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);

					// need to lookup the id					
					SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable($3->getName());					
					if(finder == NULL) {
						// TODO undecl id error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Undeclared variable '" << $3->getName() << "'" << '\n';
					}
					// else {
					// 	SymbolInfo *temp = NULL;
					// 	for(int gg = scopeTableCounter; gg > 0; gg--) {
					// 		if(symbolMap[{$3->getName(), gg}]) {
					// 			temp = $3;
					// 			$3 = symbolMap[{$3->getName(), gg}];
					// 			break;
					// 		}
					// 	}												
					// 	delete temp;
					// }

					$$->addSymbolToList($3);
					$$->addSymbolToList($4);
					$$->addSymbolToList($5);
					
		  }
	  	  | RETURN expression SEMICOLON {
					logOut << "statement : RETURN expression SEMICOLON" << '\n';
                    $$ = new SymbolInfo("RETURN expression SEMICOLON", "statement");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($3->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);
		  }
	  	  ;
	  
expression_statement 	: SEMICOLON {
							logOut << "expression_statement 	: SEMICOLON " << '\n';
							$$ = new SymbolInfo("SEMICOLON", "expression_statement");
							$$->setRuleStartLine($1->getRuleStartLine());
							$$->setRuleEndLine($1->getRuleEndLine());
							$$->setLeafNodeStatus(false);
							$$->addSymbolToList($1);
						}			
						| expression SEMICOLON {
							logOut << "expression_statement : expression SEMICOLON 		 " << '\n';
							$$ = new SymbolInfo("expression SEMICOLON", "expression_statement");
							$$->setRuleStartLine($1->getRuleStartLine());
							$$->setRuleEndLine($2->getRuleEndLine());
							$$->setLeafNodeStatus(false);
							$$->addSymbolToList($1);
							$$->addSymbolToList($2);						
						}
						| error {
							if(isError | errorLine == 0) {
								isError = false;
								errorLine = lineCount;
							} 
						} SEMICOLON {
							logOut << "expression_statement : expression SEMICOLON 		 " << '\n';
							errorOut << "Line# " << errorLine << ": Syntax error at expression of expression statement\n";
							errorCount++;
							$$ = new SymbolInfo("expression SEMICOLON", "expression_statement");
							$$->setRuleStartLine($3->getRuleStartLine());
							$$->setRuleEndLine($3->getRuleEndLine());
							$$->setLeafNodeStatus(false);
							SymbolInfo *s_temp = new SymbolInfo("error", "expression");
							s_temp->setRuleStartLine(errorLine);
							s_temp->setRuleEndLine(errorLine);
							s_temp->setLeafNodeStatus(true);
							$$->addSymbolToList(s_temp);
							$$->addSymbolToList($3);

							isError = false;
							errorLine = 0;
						}
						;
	  
variable : ID {
                    logOut << "variable : ID" << '\n';
                    $$ = new SymbolInfo("ID", "variable");					
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);

					// need to lookup the id
					SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable($1->getName());
					if(finder == NULL) {
						// TODO undecl id error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Undeclared variable '" << $1->getName() << "'" << '\n';
					}
					// else if(finder->getDataType() == "VOID" || finder->getDataType() == "") {
					else if(finder->getDataType() == "VOID") {
						// TODO void var error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Variable or field '" << finder->getName() << "' declared void\n";
					}
					else if(finder->getIsAnArray()) {
						// TODO declared var is arr but curr var is not arr error \
						i.e type mismatch of var
					}
					else {
						// SymbolInfo *temp = NULL;
						// for(int gg = scopeTableCounter; gg > 0; gg--) {
						// 	if(symbolMap[{$1->getName(), gg}]) {
						// 		temp = $1;
						// 		$1 = symbolMap[{$1->getName(), gg}];
						// 		// cout << lineCount << ' ' << $1->getName() << ' ' << $1 << '\n';
						// 		break;
						// 	}
						// }												
						// delete temp;
						$$->setDataType(finder->getDataType());
						$$->setIsAnArray($1->getIsAnArray());
					}

					$$->addSymbolToList($1);		

		 }		
	 	 | ID LSQUARE expression RSQUARE {
                    logOut << "variable : ID LSQUARE expression RSQUARE" << '\n';
                    $$ = new SymbolInfo("ID LSQUARE expression RSQUARE", "variable");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($4->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					
					SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable($1->getName());
					if(finder == NULL) {
						// TODO undecl id error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Undeclared variable '" << $1->getName() << "'" << '\n';
					}
					// else if(finder->getDataType() == "VOID" || finder->getDataType() == "") {
					else if(finder->getDataType() == "VOID") {
						// TODO void var error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Variable or field '" << finder->getName() << "' declared void\n";
					}
					else if(finder->getIsAnArray() == false) {
						// TODO type mismatch of var
						errorCount++;
						errorOut << "Line# " << lineCount << ": '" << finder->getName() << "' is not an array\n";
					}
					else {
						// SymbolInfo *temp = NULL;
						// for(int gg = scopeTableCounter; gg > 0; gg--) {
						// 	if(symbolMap[{$1->getName(), gg}]) {
						// 		temp = $1;
						// 		$1 = symbolMap[{$1->getName(), gg}];
						// 		// cout << lineCount << ' ' << $1->getName() << ' ' << $1 << '\n';
						// 		break;
						// 	}
						// }												
						// delete temp;
						$$->setDataType(finder->getDataType());
						$$->setIsAnArray(finder->getIsAnArray());
					}

					//need to check the arr indexing too --> must be int
					if($3->getDataType() != "INT") {
						// TODO invalid arr indexing
						errorCount++;
						errorOut << "Line# " << lineCount << ": Array subscript is not an integer\n";
					}

					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);
					$$->addSymbolToList($4);
		 }
	 	 ;
	 
expression : logic_expression {
                    logOut << "expression 	: logic_expression	 " << '\n';
                    $$ = new SymbolInfo("logic_expression", "expression");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);

					$$->setDataType($1->getDataType());
					$$->setIsAnArray($1->getIsAnArray());
		   }	
		   | variable ASSIGNOP logic_expression {		
                    logOut << "expression 	: variable ASSIGNOP logic_expression 		 " << '\n';
                    $$ = new SymbolInfo("variable ASSIGNOP logic_expression", "expression");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($3->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);

					// if($3->getDataType() == "VOID" || $3->getDataType() == "" || $1->getDataType() == "VOID" || $1->getDataType() == "") {
					if($3->getDataType() == "VOID" || $1->getDataType() == "VOID") {
						// TODO void func cant be in expression
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";
					}
					else if($1->getDataType() == "FLOAT" && $3->getDataType() == "INT") {
						// ok ; change int to float i gues
						$$->setDataType($1->getDataType());
					}
					else if($1->getDataType() == "INT" && $3->getDataType() == "FLOAT") {
						// TODO error/warning \
						floating point number is assigned to an integer type variable
						errorCount++;
						errorOut << "Line# " << lineCount << ": Warning: possible loss of data in assignment of FLOAT to INT" << '\n';
						$$->setDataType($1->getDataType());
					}
					else if($1->getDataType() != $3->getDataType() && $1->getDataType() != "" && $3->getDataType() != "") {
						// TODO type mismatch error
					}
					else if($1->getIsAnArray() != $3->getIsAnArray()) {
						errorCount++;
						errorOut << "Line# " << lineCount << ": Warning: wrong type cast" << '\n';
					}
					else {
						$$->setDataType($1->getDataType());
					}
		   }
		   ;
			
logic_expression : rel_expression {
                    logOut << "logic_expression : rel_expression" << '\n';
                    $$ = new SymbolInfo("rel_expression", "logic_expression");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);

					$$->setDataType($1->getDataType());
					$$->setIsAnArray($1->getIsAnArray());
				 }
		 		 | rel_expression LOGICOP rel_expression {
					logOut << "logic_expression : rel_expression LOGICOP rel_expression" << '\n';
                    $$ = new SymbolInfo("rel_expression LOGICOP rel_expression", "logic_expression");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($3->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);

					// if($1->getDataType() == "VOID" || $3->getDataType() == "VOID" || $1->getDataType() == "" || $3->getDataType() == "") {
					if($1->getDataType() == "VOID" || $3->getDataType() == "VOID") {
						// TODO VOID in logicop cant happen
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";
					}
					else {
						$$->setDataType("INT");
					}
					
				 }
		 		 ;
			
rel_expression	: simple_expression {
                    logOut << "rel_expression	: simple_expression" << '\n';
                    $$ = new SymbolInfo("simple_expression", "rel_expression");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);

					$$->setDataType($1->getDataType());
					$$->setIsAnArray($1->getIsAnArray());
				}
				| simple_expression RELOP simple_expression	{
                    logOut << "rel_expression	: simple_expression RELOP simple_expression" << '\n';
                    $$ = new SymbolInfo("simple_expression RELOP simple_expression", "rel_expression");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($3->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);

					if($1->getDataType() == "VOID" || $3->getDataType() == "VOID") {
						// TODO void func in relop nonon
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";
					}
					else if($1->getDataType() == "" || $3->getDataType() == "") {
						// TODO error 
					}
					else {
						$$->setDataType("INT");
					}
				}
				;
				
simple_expression : term {
                    logOut << "simple_expression : term" << '\n';
                    $$ = new SymbolInfo("term", "simple_expression");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);

					$$->setDataType($1->getDataType());
					$$->setIsAnArray($1->getIsAnArray());
				  }
		  		  | simple_expression ADDOP term {
                    logOut << "simple_expression : simple_expression ADDOP term" << '\n';
                    $$ = new SymbolInfo("simple_expression ADDOP term", "simple_expression");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($3->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);

					// if($1->getDataType() == "VOID" || $3->getDataType() == "VOID" || $1->getDataType() == "" || $3->getDataType() == "") {
					if($1->getDataType() == "VOID" || $3->getDataType() == "VOID") {
						// TODO error void func in simple_expression
						// TODO void func cant be in expression
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";
					}

					else {
						if($1->getDataType() == "INT" || $3->getDataType() == "INT") {
							$$->setDataType($1->getDataType());
						}
						else if($1->getDataType() == "FLOAT" || $3->getDataType() == "INT") {
							$$->setDataType($1->getDataType());
						}
						else if($1->getDataType() == "INT" || $3->getDataType() == "FLOAT") {
							$$->setDataType($3->getDataType());
						}
						else {
							// TODO error
						}
					}
				  }
		  		  ;
					
term :	unary_expression {
                    logOut << "term :	unary_expression" << '\n';
                    $$ = new SymbolInfo("unary_expression", "term");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);

					$$->setDataType($1->getDataType());
					$$->setIsAnArray($1->getIsAnArray());
	 }
     |  term MULOP unary_expression {
                    logOut << "term :	term MULOP unary_expression" << '\n';
                    $$ = new SymbolInfo("term MULOP unary_expression", "term");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($3->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);

					if($1->getDataType() == "VOID" || $3->getDataType() == "VOID") {
						// TODO void func error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";
					}
				
					if($2->getName() == "%") {
						// operands of mod op must be ints
						// also need to check for div by zero	
						if($1->getDataType() == "INT" && $3->getDataType() == "INT") {
							if(isZeroVal) {
							// TODO mod by zero error
							errorCount++;
							errorOut << "Line# " << lineCount << ": Warning: division by zero" << '\n';
							}	
							else {
								$$->setDataType("INT");
							}
						}
						else {
							// TODO mod ops not int error
							errorCount++;
							errorOut << "Line# " << lineCount << ": Operands of modulus must be integers " << '\n';
						}
					}
					else if($2->getName() == "/") {
						if(($1->getDataType() == "INT" || $1->getDataType() == "FLOAT") && ($3->getDataType() == "INT" || $3->getDataType() == "FLOAT")) {
							if(isZeroVal) {
								// TODO div by zero error
								errorCount++;
								errorOut << "Line# " << lineCount << ": Warning: division by zero" << '\n';
							}
							else {
								if($1->getDataType() == "FLOAT" || $3->getDataType() == "FLOAT") {
									$$->setDataType("FLOAT");
								}
								else {
									$$->setDataType("INT");
								}
							}
						}
						else {
							// TODO void func error in exprssn
						}
					}
					else {
						if(($1->getDataType() == "INT" || $1->getDataType() == "FLOAT") && ($3->getDataType() == "INT" || $3->getDataType() == "FLOAT")) {
							if($1->getDataType() == "FLOAT" || $3->getDataType() == "FLOAT") {
								$$->setDataType("FLOAT");
							}
							else {
								$$->setDataType("INT");
							}
						}
						else {
							// TODO void func error in exprssn
						}
					}
					isZeroVal = false;
	 }
     ;

unary_expression : ADDOP unary_expression {
                    logOut << "unary_expression : ADDOP unary_expression" << '\n';
                    $$ = new SymbolInfo("ADDOP unary_expression", "unary_expression");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($2->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);

					// if($2->getDataType() == "VOID" || $2->getDataType() == "") {
					if($2->getDataType() == "VOID") {
						// TODO void func in exprssn error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";
					}
					else {
						$$->setDataType($2->getDataType());
					}
				 } 
		 		 | NOT unary_expression {
                    logOut << "unary_expression : NOT unary_expression" << '\n';
                    $$ = new SymbolInfo("NOT unary_expression", "unary_expression");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($2->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);

					// if($2->getDataType() == "VOID" || $2->getDataType() == "") {
					if($2->getDataType() == "VOID") {
						// TODO void func in exprssn error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";
					}
					else {
						$$->setDataType("INT");
					}
				 }
		 		 | factor {
                    logOut << "unary_expression : factor" << '\n';
                    $$ = new SymbolInfo("factor", "unary_expression");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);

					$$->setDataType($1->getDataType());
					$$->setIsAnArray($1->getIsAnArray());
				 }
		 		 ;
	
factor	: variable {
                    logOut << "factor	: variable " << '\n';
                    $$ = new SymbolInfo("variable", "factor");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);

					if($1->getDataType() == "VOID" || $1->getDataType() == "") {
						// TODO void func in var error
					}
					else {
						$$->setDataType($1->getDataType());
						$$->setIsAnArray($1->getIsAnArray());
					}
		}
		| ID LPAREN argument_list RPAREN {
                    logOut << "factor	: ID LPAREN argument_list RPAREN " << '\n';
                    $$ = new SymbolInfo("ID LPAREN argument_list RPAREN", "factor");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($4->getRuleEndLine());
					$$->setLeafNodeStatus(false);					

					SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable($1->getName());
					if(finder == NULL) {
						// TODO func not defined err
						errorCount++;
						errorOut << "Line# " << lineCount << ": Undeclared function '" << $1->getName() << "'" << '\n';
					}
					else {						
						$$->setDataType(finder->getDataType());						
						if(!(finder->getIsAFunction())) {
							// TODO not a func error
							// errorOut << "gege\n";
							errorCount++;
							errorOut << "Line# " << lineCount << ": Conflicting types for '" << $1->getName() << "'" << '\n';
						}
						else if(!(finder->getIsFunctionDefined())) {
							// TODO func not defined
							errorCount++;
							errorOut << "Line# " << lineCount << ": Undefined function '" << $1->getName() << "'" << '\n';
						}
						else {
							// need to check param length and types
							vector<SymbolInfo *> v1, v2;
							v1 = finder->getFunctionParameterList();
							v2 = $3->getFunctionParameterList();
							if(v1.size() != v2.size()) {
								// TODO func param length mismatch error
								if(v1.size() > v2.size()) {
									errorCount++;
									errorOut << "Line# " << lineCount << ": Too few arguments to function '" << finder->getName() << "'" << '\n';
								}
								else {
									errorCount++;
									errorOut << "Line# " << lineCount << ": Too many arguments to function '" << finder->getName() << "'" << '\n';
								}
							}
							else {
								bool isGood = true;
								for(int i = 0; i < v1.size(); i++) {
									if(v1[i]->getDataType() != v2[i]->getDataType()) {
										isGood = false;
										// TODO Type mismatch for argument 1 of 'func'
										errorOut << "Line# " << lineCount << ": Type mismatch for argument " << i+1 << " of '" << finder->getName() << "'" << '\n';
										errorCount++;
										// break;
									}
								}
								if(isGood) {
									// SymbolInfo *temp = NULL;
									// for(int gg = scopeTableCounter; gg > 0; gg--) {
									// 	if(symbolMap[{$1->getName(), gg}]) {
									// 		temp = $1;
									// 		$1 = symbolMap[{$1->getName(), gg}];
									// 		break;
									// 	}
									// }												
									// delete temp;
									$$->setDataType(finder->getDataType());
								}
								else {
									// TODO conflicting types error maybe
								}
							}
						}						
					}
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);
					$$->addSymbolToList($4);
		}
		| LPAREN expression RPAREN {
                    logOut << "factor	: LPAREN expression RPAREN " << '\n';
                    $$ = new SymbolInfo("LPAREN expression RPAREN", "factor");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($3->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);
					$$->addSymbolToList($3);

					if($2->getDataType() == "VOID" || $2->getDataType() == "") {
						// TODO void func in var error
					}
					else {
						$$->setDataType($2->getDataType());
					}
		}
		| CONST_INT {
                    logOut << "factor	: CONST_INT " << '\n';
                    $$ = new SymbolInfo("CONST_INT", "factor");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);

					$$->setDataType("INT");
					int temp = stoi($1->getName());
					if(temp == 0) {
						isZeroVal = true;
					}
		}
		| CONST_FLOAT {
                    logOut << "factor	: CONST_FLOAT " << '\n';
                    $$ = new SymbolInfo("CONST_FLOAT", "factor");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($1->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);

					$$->setDataType("FLOAT");
					float temp = stof($1->getName());
					if(temp == 0) {
						isZeroVal = true;
					}
		}
		| variable INCOP {
                    logOut << "factor	: variable INCOP " << '\n';
                    $$ = new SymbolInfo("variable INCOP", "factor");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($2->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);

					// if($1->getDataType() == "VOID" || $1->getDataType() == "") {
					if($1->getDataType() == "VOID") {
						// TODO void func in var error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";

					}
					else {
						$$->setDataType($1->getDataType());
					}
		}
		| variable DECOP {
                    logOut << "factor	: variable DECOP " << '\n';
                    $$ = new SymbolInfo("variable DECOP", "factor");
					$$->setRuleStartLine($1->getRuleStartLine());
					$$->setRuleEndLine($2->getRuleEndLine());
					$$->setLeafNodeStatus(false);
					$$->addSymbolToList($1);
					$$->addSymbolToList($2);

					// if($1->getDataType() == "VOID" || $1->getDataType() == "") {
					if($1->getDataType() == "VOID") {
						// TODO void func in var error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";

					}
					else {
						$$->setDataType($1->getDataType());
					}
		}
		;
	
argument_list : arguments {
				logOut << "argument_list : arguments" << '\n';
				$$ = new SymbolInfo("arguments", "argument_list");
				$$->setRuleStartLine($1->getRuleStartLine());
				$$->setRuleEndLine($1->getRuleEndLine());
				$$->setLeafNodeStatus(false);
				$$->addSymbolToList($1);

				for(SymbolInfo *s : functionParameterList) {
					$$->addFunctionParameterToList(s);
				}
				functionParameterList.clear();	
			  }
			  | {
				logOut << "argument_list : " << '\n';
				$$ = new SymbolInfo("", "argument_list");
				$$->setRuleStartLine(lineCount);
				$$->setRuleEndLine(lineCount);
				$$->setLeafNodeStatus(false);
				
				for(SymbolInfo *s : functionParameterList) {
					$$->addFunctionParameterToList(s);
				}
				functionParameterList.clear();	
			  }
			  ;
	
arguments : arguments COMMA logic_expression {
				logOut << "arguments : arguments COMMA logic_expression" << '\n';
				$$ = new SymbolInfo("arguments COMMA logic_expression", "arguments");
				$$->setRuleStartLine($1->getRuleStartLine());
				$$->setRuleEndLine($3->getRuleEndLine());
				$$->setLeafNodeStatus(false);
				$$->addSymbolToList($1);
				$$->addSymbolToList($2);
				$$->addSymbolToList($3);

				functionParameterList.push_back($3);
		  }
	      | logic_expression {
				logOut << "arguments : logic_expression" << '\n';
				$$ = new SymbolInfo("logic_expression", "arguments");
				$$->setRuleStartLine($1->getRuleStartLine());
				$$->setRuleEndLine($1->getRuleEndLine());
				$$->setLeafNodeStatus(false);
				$$->addSymbolToList($1);

				functionParameterList.push_back($1);
		  }
	      ;
 

%%

void start(SymbolInfo*);
void program(SymbolInfo*);
void unit(SymbolInfo*);
void var_declaration(SymbolInfo*);
void declaration_list(SymbolInfo*);
void func_definition(SymbolInfo*);
void compound_statement(SymbolInfo*);
void statements(SymbolInfo*);
void statement(SymbolInfo*);
void println(SymbolInfo*);
void expression_statement(SymbolInfo*);
void expression(SymbolInfo*);
void logic_expression(SymbolInfo*);
void rel_expression(SymbolInfo*);
void simple_expression(SymbolInfo*);
void term(SymbolInfo*);
void unary_expression(SymbolInfo*);
void factor(SymbolInfo*);
void variable(SymbolInfo*, bool);
void argument_list(SymbolInfo*);
void arguments(SymbolInfo*);
void parameter_list(SymbolInfo*);


void parameter_list(SymbolInfo* parameter_list_si) {
	vector<SymbolInfo*> temp = parameter_list_si->getParseTreeChildList();
	if(temp.size() == 2) {
		temp[1]->baseOffset = anotherOffset + 2;
		anotherOffset += 2;
		functionParameterList.push_back(temp[1]);
		/* cout << "\n\n" << temp[1] << "\n\n"; */
	}
	else if(temp[0]->getType() == "parameter_list") {
		parameter_list(temp[0]);
		if(temp.size() == 4) {
			temp[3]->baseOffset = anotherOffset + 2;
			anotherOffset += 2;
			functionParameterList.push_back(temp[3]);
			/* cout << "\n\n" << temp[3] << "\n\n"; */
		}
	}
}


void start(SymbolInfo* start_si) {
	// call program
	codeasm << ".MODEL SMALL\n";
	codeasm << ".STACK 1000H\n";
	codeasm << ".DATA\n";
	codeasm << "\tCR EQU 0DH\n";
	codeasm << "\tLF EQU 0AH\n";
	codeasm << "\tnumber DB \"00000$\"\n";
	symbolTable->printAllGlobalVarsInASM(codeasm);
	codeasm << ".CODE\n";
	program(start_si->getParseTreeChildList()[0]);
	codeasm << print_output_proc;
	codeasm << new_line_proc;
	codeasm << "END MAIN\n";
}

void program(SymbolInfo* program_si) {
	// call unit or call program unit
	vector<SymbolInfo*> temp = program_si->getParseTreeChildList();
	if(temp[0]->getType() == "program") {
		program(temp[0]);
		unit(temp[1]);
	}
	else {
		unit(temp[0]);
	}
}

void unit(SymbolInfo* unit_si) {
	SymbolInfo *temp = unit_si->getParseTreeChildList()[0];
	// check the 3 cases of unit
	if(temp->getType() == "var_declaration") {
		codeasm << "\t;Line no " << temp->getRuleStartLine() << " var_declaration\n";
		/* var_declaration(temp, false); */
	}
	if(temp->getType() == "func_definition") {
		codeasm << "\t;Line no " << temp->getRuleStartLine() << " func_definition\n";
		func_definition(temp);
	}
}

void var_declaration(SymbolInfo* var_declaration_si) {
	SymbolInfo *type_specifier_si = var_declaration_si->getParseTreeChildList()[0];
	SymbolInfo *declaration_list_si = var_declaration_si->getParseTreeChildList()[1];
	if(type_specifier_si->getName() == "INT") {
		declaration_list(declaration_list_si);
	}
}

void declaration_list(SymbolInfo* declaration_list_si) {
	vector<SymbolInfo*> tempList = declaration_list_si->getParseTreeChildList();
	if(tempList[0]->getType() == "declaration_list") {
		if(tempList.size() == 3) {
			declaration_list(tempList[0]);
			SymbolInfo *finder = NULL;
			if(symbolTable->insertSymbolInSymbolTable(tempList[2], logOut)) {
				finder = symbolTable->lookUpSymbolInSymbolTable(tempList[2]->getName());
				printAboutVarInASM(finder, 1);
			}
			else {
				errorCount++;
				cout << "Error in declaration list\n";
			}			
		}
		else {
			declaration_list(tempList[0]);
			SymbolInfo *finder = NULL;
			if(symbolTable->insertSymbolInSymbolTable(tempList[2], logOut)) {
				finder = symbolTable->lookUpSymbolInSymbolTable(tempList[2]->getName());
				printAboutVarInASM(finder, stoi(tempList[4]->getName()));
			}
			else {
				errorCount++;
				cout << "Error in declaration list\n";
			}
		}
	}
	else {
		if(tempList.size() == 1) {	
			SymbolInfo *finder = NULL;
			if(symbolTable->insertSymbolInSymbolTable(tempList[0], logOut)) {
				finder = symbolTable->lookUpSymbolInSymbolTable(tempList[0]->getName());
				printAboutVarInASM(finder, 1);
			}
			else {
				errorCount++;
				cout << "Error in declaration list\n";
			}					
		}
		else {	
			SymbolInfo *finder = NULL;
			if(symbolTable->insertSymbolInSymbolTable(tempList[0], logOut)) {
				finder = symbolTable->lookUpSymbolInSymbolTable(tempList[0]->getName());
				printAboutVarInASM(finder, stoi(tempList[2]->getName()));
			}
			else {
				errorCount++;
				cout << "Error in declaration list\n";
			}					
		}
	}
}

void func_definition(SymbolInfo* func_definition_si) {
	vector<SymbolInfo *> temp = func_definition_si->getParseTreeChildList();
	globalLabel = genLabel();
	anotherOffset = 2;
	offsetForVar = 0;
	codeasm << temp[1]->getName() << " PROC\n";
	if(temp[1]->getName() == "main") {
		codeasm << "\tMOV AX, @DATA\n";
		codeasm << "\tMOV DS, AX\n";
	}
	codeasm << "\tPUSH BP\n";
	codeasm << "\tMOV BP, SP\n";

	if(temp.size() == 6) {
		functionParameterList.clear();
		codeasm << "\t;Line no " << temp[3]->getRuleStartLine() << " parameter_list\n";
		parameter_list(temp[3]);
		codeasm << "\t;Line no " << temp[5]->getRuleStartLine() << " compound_statement\n";
		compound_statement(temp[5]);
	}
	else {
		codeasm << "\t;Line no " << temp[4]->getRuleStartLine() << " compound_statement\n";
		compound_statement(temp[4]);
	}

	codeasm << globalLabel << ":\n";
	codeasm << "\tMOV SP, BP\n";
	codeasm << "\tPOP BP\n";
	if(temp[1]->getName() == "main") {
		codeasm << "\tMOV AX, 4CH\n";
		codeasm << "\tINT 21H\n";
	}
	else if(anotherOffset > 2) {
		codeasm << "\tRET " << anotherOffset - 2 << '\n';
	}
	else {
		codeasm << "\tRET\n";
	}
	codeasm << temp[1]->getName() << " ENDP\n";
	globalLabel = "";
	anotherOffset = 2;
	offsetForVar = 0;
}

void compound_statement(SymbolInfo* compound_statement_si) {
	if(compound_statement_si->getParseTreeChildList().size() == 3) {
		symbolTable->enterScope(scopeTableCounter++, num_of_buckets);
		for(SymbolInfo *s : functionParameterList) {
			if(!(symbolTable->insertSymbolInSymbolTable(s, logOut))) {
				errorCount++;
				cout << "Error inserting func params to symbol table\n";
			}
		}
		functionParameterList.clear();
		/* codeasm << "\t;Line no " << lineCount << " statements\n"; */
		statements(compound_statement_si->getParseTreeChildList()[1]);
		symbolTable->exitScope();
	}
}

void statements(SymbolInfo* statements_si) {
	if(statements_si->getParseTreeChildList().size() == 1) {
		/* codeasm << "\t;Line no " << lineCount << " statement\n";	 */
		statement(statements_si->getParseTreeChildList()[0]);
	}
	else {
		statements(statements_si->getParseTreeChildList()[0]);
		/* codeasm << "\t;Line no " << lineCount << " statement\n"; */
		statement(statements_si->getParseTreeChildList()[1]);
	}
}

void statement(SymbolInfo* statement_si) {
	codeasm << genLabel() << ":\n";
	vector<SymbolInfo *> tempList = statement_si->getParseTreeChildList();
	if(tempList[0]->getType() == "var_declaration") {
		codeasm << "\t;Line no " << tempList[0]->getRuleStartLine() << " var_declaration\n";
		var_declaration(tempList[0]);
	}
	else if(tempList[0]->getType() == "compound_statement") {
		codeasm << "\t;Line no " << tempList[0]->getRuleStartLine() << " compound_statement\n";
		compound_statement(tempList[0]);
	}
	else if(tempList[0]->getType() == "PRNTLN") {
		codeasm << "\t;Line no " << tempList[0]->getRuleStartLine() << " println\n";
		println(tempList[2]);
	}
	else if(tempList[0]->getType() == "expression_statement") {
		codeasm << "\t;Line no " << tempList[0]->getRuleStartLine() << " expression_statement\n";
		expression_statement(tempList[0]);
	}
	else if(tempList[0]->getType() == "IF") {		
		if(tempList.size() == 5) {
			codeasm << "\t;Line no " << tempList[0]->getRuleStartLine() << " IF BLOCK\n";
			string label = genLabel();
			expression(tempList[2]);
			codeasm << "\tPOP AX\n";
			codeasm << "\tCMP AX, 0\n";
			codeasm << "\tJE " << label << '\n';
			statement(tempList[4]);
			codeasm << label << ":\n";
		}
		else {
			codeasm << "\t;Line no " << tempList[0]->getRuleStartLine() << " IF ELSE BLOCK\n";
			string label1 = genLabel();
			string label2 = genLabel();
			expression(tempList[2]);
			codeasm << "\tPOP AX\n";
			codeasm << "\tCMP AX, 0\n";
			codeasm << "\tJE " << label1 << '\n';
			statement(tempList[4]);
			codeasm << "\tJMP " << label2 << '\n';
			codeasm << label1 << ":\n";
			statement(tempList[6]);
			codeasm << label2 << ":\n";
		}
	}
	else if(tempList[0]->getType() == "WHILE") {
		codeasm << "\t;Line no " << tempList[0]->getRuleStartLine() << " WHILE LOOP\n";
		string label1 = genLabel();
		string label2 = genLabel();
		codeasm << label1 << ":\n";
		expression(tempList[2]);
		codeasm << "\tPOP AX\n";
		codeasm << "\tCMP AX, 0\n";
		codeasm << "\tJE " << label2 << '\n';
		statement(tempList[4]);
		codeasm << "\tJMP " << label1 << '\n';
		codeasm << label2 << ":\n";
	}
	else if(tempList[0]->getType() == "FOR") {
		codeasm << "\t;Line no " << tempList[0]->getRuleStartLine() << " FOR LOOP\n";
		expression_statement(tempList[2]);
		string label1 = genLabel();
		string label2 = genLabel();
		codeasm << label1 << ":\n";
		expression_statement(tempList[3]);
		codeasm << "\tCMP AX, 0\n";
		codeasm << "\tJE " << label2 << '\n';
		statement(tempList[6]);
		expression(tempList[4]);
		codeasm << "\tPOP AX\n";
		codeasm << "\tJMP " << label1 << '\n';
		codeasm << label2 << ":\n";
	}
	else if(tempList[0]->getType() == "RETURN") {
		codeasm << "\t;Line no " << tempList[0]->getRuleStartLine() << " RETURN STATEMENT\n";
		expression(tempList[1]);
		codeasm << "\tPOP AX\n";
		codeasm << "\tJMP " << globalLabel << '\n';
	}
}

void println(SymbolInfo* id) {
	SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable(id->getName());
	if(finder == NULL) {
		errorCount++;
		cout << "Undeclared ID\n";
	}
	else {
		/* codeasm << "\tPUSH AX\n"; */
		if(finder->baseOffset == 0) {
		codeasm << "\tMOV AX, " << finder->getName() << '\n';
		}
		else {
			string sign = finder->baseOffset > 0 ? "+" : "";
			codeasm << "\tMOV AX, " << "[BP" << sign << finder->baseOffset << "]\n";
		}
		codeasm << "\tCALL PRINT_OUTPUT\n";
		codeasm << "\tCALL NEW_LINE\n";
		/* codeasm << "\tPOP AX\n"; */
	}
}

void expression_statement(SymbolInfo* expression_statement_si) {
	if(expression_statement_si->getParseTreeChildList()[0]->getType() == "expression") {
		codeasm << "\t;Line no " << expression_statement_si->getParseTreeChildList()[0]->getRuleStartLine() << " expression\n";
		expression(expression_statement_si->getParseTreeChildList()[0]);
		codeasm << "\tPOP AX\n";
	}
}

void expression(SymbolInfo* expression_si) {
	vector<SymbolInfo*> temp = expression_si->getParseTreeChildList();
	if(temp[0]->getType() == "logic_expression") {
		/* codeasm << "\t;Line no " << lineCount << " logic_expression\n"; */
		logic_expression(temp[0]);
		codeasm << "\tPOP AX\n";
	}
	else if(temp[0]->getType() == "variable") {
		/* codeasm << "\t;Line no " << lineCount << " logic_expression\n"; */
		logic_expression(temp[2]);
		codeasm << "\tPOP AX\n";
		codeasm << "\t;Line no " << temp[0]->getRuleStartLine() << " variable assignop\n";
		variable(temp[0], false);
	}
	codeasm << "\tPUSH AX\n";
}

void variable(SymbolInfo* variable_si, bool side) {
	vector<SymbolInfo*> temp = variable_si->getParseTreeChildList();
	SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable(temp[0]->getName());
	if(finder == NULL) {
		errorCount++;
		cout << "Undeclared Variable\n";
	}
	else {
		if(!side) {
		if(temp.size() == 1) {
			if(finder->baseOffset == 0) {
				codeasm << "\tMOV " << finder->getName() << ", AX\n";
			}
			else {
				string sign = finder->baseOffset > 0 ? "+" : "";
				codeasm << "\tMOV [BP" << sign << finder->baseOffset << "], AX\n";			
			}
		}
		else {
			codeasm << "\tPUSH SI\n";
			codeasm << "\tPUSH AX\n";
			expression(temp[2]);
			codeasm << "\tPOP BX\n"; // value of expression is now in BX
			if(finder->baseOffset == 0) {
				codeasm << "\tLEA SI, " << finder->getName() << '\n';
				codeasm << "\tADD SI, BX\n";
				codeasm << "\tADD SI, BX\n";				
				codeasm << "\tPOP AX\n";
				codeasm << "\tMOV [SI], AX\n";
				codeasm << "\tPOP SI\n";
			}
			else {
				codeasm << "\tMOV SI, " << finder->baseOffset << '\n';
				codeasm << "\tSUB SI, BX\n";
				codeasm << "\tSUB SI, BX\n";				
				codeasm << "\tPOP AX\n";
				codeasm << "\tMOV [BP+SI], AX\n";
				codeasm << "\tPOP SI\n";				
			}
		}
	}
	else {
		if(temp.size() == 1) {
			if(finder->baseOffset == 0) {
				codeasm << "\tMOV AX, " << finder->getName() << '\n';
				if(doIncop) {
					codeasm << "\tINC " << finder->getName() << '\n';
				}
				if(doDecop) {
					codeasm << "\tDEC " << finder->getName() << '\n';
				}
			}
			else {
				string sign = finder->baseOffset > 0 ? "+" : "";
				codeasm << "\tMOV AX, " << "[BP" << sign << finder->baseOffset << "]\n";
				if(doIncop) {
					codeasm << "\tMOV CX, " << "[BP" << sign << finder->baseOffset << "]\n";
					codeasm << "\tINC CX\n";
					codeasm << "\tMOV [BP" << sign << finder->baseOffset << "], CX\n";
				}
				if(doDecop) {
					codeasm << "\tMOV CX, " << "[BP" << sign << finder->baseOffset << "]\n";
					codeasm << "\tDEC CX\n";
					codeasm << "\tMOV [BP" << sign << finder->baseOffset << "], CX\n";
				}
			}
		}
		else {
			codeasm << "\tPUSH SI\n";
			expression(temp[2]);
			codeasm << "\tPOP BX\n"; // value of expression is now in BX
			if(finder->baseOffset == 0) {
				codeasm << "\tLEA SI, " << finder->getName() << '\n';
				codeasm << "\tADD SI, BX\n";
				codeasm << "\tADD SI, BX\n";				
				codeasm << "\tMOV AX, [SI]\n";
				if(doIncop) {
					codeasm << "\tMOV CX, [SI]\n";
					codeasm << "\tINC CX\n";
					codeasm << "\tMOV [SI], CX\n";
				}
				if(doDecop) {
					codeasm << "\tMOV CX, [SI]\n";
					codeasm << "\tDEC CX\n";
					codeasm << "\tMOV [SI], CX\n";
				}
				codeasm << "\tPOP SI\n";
			}
			else {
				codeasm << "\tMOV SI, " << finder->baseOffset << '\n';
				codeasm << "\tSUB SI, BX\n";
				codeasm << "\tSUB SI, BX\n";				
				codeasm << "\tMOV AX, [BP+SI]\n";
				if(doIncop) {
					codeasm << "\tMOV CX, [BP+SI]\n";
					codeasm << "\tINC CX\n";
					codeasm << "\tMOV [BP+SI], CX\n";
				}
				if(doDecop) {
					codeasm << "\tMOV CX, [BP+SI]\n";
					codeasm << "\tDEC CX\n";
					codeasm << "\tMOV [BP+SI], CX\n";
				}
				codeasm << "\tPOP SI\n";				
			}
		}
	}
	}	
}

void logic_expression(SymbolInfo* logic_expression_si) {
	vector<SymbolInfo*> temp = logic_expression_si->getParseTreeChildList();
	if(temp[0]->getType() == "rel_expression") {
		if(temp.size() == 1) {
			/* codeasm << "\t;Line no " << lineCount << " rel_expression\n"; */
			rel_expression(temp[0]);
			codeasm << "\tPOP AX\n";
		}
		else {
			/* codeasm << "\t;Line no " << lineCount << " rel_expression with logicop\n"; */
			rel_expression(temp[0]);
			codeasm << "\tPOP AX\n";
			string label1 = genLabel();
			string label2 = genLabel();
			if(temp[1]->getName() == "||") {
				codeasm << "\tCMP AX, 0\n";
				codeasm << "\tJNE " << label1 << '\n';
				codeasm << "\t;Line no " << temp[1]->getRuleStartLine() << " rel_expression with logicop ||\n";
				rel_expression(temp[2]);
				codeasm << "\tPOP BX\n";
				codeasm << "\tCMP BX, 0\n";
				codeasm << "\tJNE " << label1 << '\n';
				codeasm << "\tMOV AX, 0\n";
				codeasm << "\tJMP " << label2 << '\n';
				codeasm << label1 << ":\n";
				codeasm << "\tMOV AX, 1\n";
				codeasm << label2 << ":\n";			
			}
			else if(temp[1]->getName() == "&&") {
				codeasm << "\tCMP AX, 0\n";
				codeasm << "\tJE " << label1 << '\n';
				codeasm << "\t;Line no " << temp[1]->getRuleStartLine() << " rel_expression with logicop &&\n";
				rel_expression(temp[2]);
				codeasm << "\tPOP BX\n";
				codeasm << "\tCMP BX, 0\n";
				codeasm << "\tJE " << label1 << '\n';
				codeasm << "\tMOV AX, 1\n";
				codeasm << "\tJMP " << label2 << '\n';
				codeasm << label1 << ":\n";
				codeasm << "\tMOV AX, 0\n";
				codeasm << label2 << ":\n";	
			}
		}
	}
	codeasm << "\tPUSH AX\n";
}

void rel_expression(SymbolInfo* rel_expression_si) {
	vector<SymbolInfo*> temp = rel_expression_si->getParseTreeChildList();
	if(temp[0]->getType() == "simple_expression") {
		if(temp.size() == 1) {
			/* codeasm << "\t;Line no " << lineCount << " simple_expression\n"; */
			simple_expression(temp[0]);
			codeasm << "\tPOP AX\n";
		}
		else {
			codeasm << "\t;Line no " << temp[1]->getRuleStartLine() << " simple_expression with relop\n";
			simple_expression(temp[0]);
			simple_expression(temp[2]);
			codeasm << "\tPOP BX\n";
			codeasm << "\tPOP AX\n";
			string relop_si = temp[1]->getName();
			codeasm << "\tCMP AX, BX\n";
			string label1 = genLabel();
			string label2 = genLabel();
			if(relop_si == "<") relop_si = "JL ";
			if(relop_si == "<=") relop_si = "JLE ";
			if(relop_si == ">") relop_si = "JG ";
			if(relop_si == ">=") relop_si = "JGE ";
			if(relop_si == "==") relop_si = "JE ";
			if(relop_si == "!=") relop_si = "JNE ";
			codeasm << "\t" << relop_si << label1 << '\n';
			codeasm << "\tMOV AX, 0\n";
			codeasm << "\tJMP " << label2 << '\n';
			codeasm << label1 << ":\n";
			codeasm << "\tMOV AX, 1\n";
			codeasm << label2 << ":\n";
		}
	}
	codeasm << "\tPUSH AX\n";
}

void simple_expression(SymbolInfo* simple_expression_si) {
	vector<SymbolInfo*> temp = simple_expression_si->getParseTreeChildList();
	if(temp[0]->getType() == "term") {
		/* codeasm << "\t;Line no " << lineCount << " term\n"; */
		term(temp[0]);
	}
	else {
		simple_expression(temp[0]);
		term(temp[2]);
		codeasm << "\tPOP BX\n";
		codeasm << "\tPOP AX\n";
		if(temp[1]->getName() == "+") {
			codeasm << "\t;Line no " << temp[1]->getRuleStartLine() << " term addition\n";
			codeasm << "\tADD AX, BX\n";
		}
		else {
			codeasm << "\t;Line no " << temp[1]->getRuleStartLine() << " term subtraction\n";
			codeasm << "\tSUB AX, BX\n";
		}
		codeasm << "\tPUSH AX\n";
	}
}

void term(SymbolInfo* term_si) {
	vector<SymbolInfo*> temp = term_si->getParseTreeChildList();
	if(temp[0]->getType() == "unary_expression") {
		/* codeasm << "\t;Line no " << lineCount << " unary_expression\n"; */
		unary_expression(temp[0]);
	}
	else {
		/* codeasm << "\t;Line no " << lineCount << " term mulop unary_expression\n"; */
		term(temp[0]);
		unary_expression(temp[2]);
		codeasm << "\tPOP BX\n";
		codeasm << "\tPOP AX\n";

		codeasm << "\tCWD\n";
		if(temp[1]->getName() == "*") {
			codeasm << "\t;Line no " << temp[1]->getRuleStartLine() << " multiplication op\n";
			codeasm << "\tIMUL BX\n";
		}
		else if(temp[1]->getName() == "/") {
			codeasm << "\t;Line no " << temp[1]->getRuleStartLine() << " division op\n";
			codeasm << "\tIDIV BX\n";
		}
		else if(temp[1]->getName() == "%") {
			codeasm << "\t;Line no " << temp[1]->getRuleStartLine() << " modulus op\n";
			codeasm << "\tIDIV BX\n";
			codeasm << "\tMOV AX, DX\n";
		}		
		codeasm << "\tPUSH AX\n";
	}	
}

void unary_expression(SymbolInfo* unary_expression_si) {
	vector<SymbolInfo*> temp = unary_expression_si->getParseTreeChildList();
	if(temp[0]->getType() == "factor") {
		/* codeasm << "\t;Line no " << lineCount << " factor\n"; */
		factor(temp[0]);		
	}
	else {
		unary_expression(temp[1]);
		codeasm << "\tPOP AX\n";
		if(temp[0]->getName() == "-") {
			codeasm << "\t;Line no " << temp[0]->getRuleStartLine() << " NEGATION of factor\n";
			codeasm << "\tNEG AX\n";
		}
		else if(temp[0]->getName() == "!") {
			codeasm << "\t;Line no " << temp[0]->getRuleStartLine() << " NOT op of factor\n";
			string label1 = genLabel();
			string label2 = genLabel();
			codeasm << "\tCMP AX, 0\n";
			codeasm << "\tJE " << label1 << '\n';
			codeasm << "\tMOV AX, 0\n";
			codeasm << "\tJMP " << label2 << '\n';
			codeasm << label1 << ":\n";
			codeasm << "\tMOV AX, 1\n";
			codeasm << label2 << ":\n";			
		}
		codeasm << "\tPUSH AX\n";
	}
}

void factor(SymbolInfo* factor_si) {
	vector<SymbolInfo*> temp = factor_si->getParseTreeChildList();
	if(temp[0]->getType() == "CONST_INT") {
		codeasm << "\t;Line no " << temp[0]->getRuleStartLine() << " CONST_INT with value " << temp[0]->getName() << '\n';
		codeasm << "\tMOV AX, " << temp[0]->getName() << '\n';
	}
	else if(temp[0]->getType() == "variable") {
		codeasm << "\t;Line no " << temp[0]->getRuleStartLine() << " variable as factor\n";
		if(temp.size() == 1) {
			variable(temp[0], true);
		}
		else if(temp[1]->getType() == "INCOP") {
			codeasm << "\t;Line no " << temp[1]->getRuleStartLine() << " variable INCOP\n";
			doIncop = true;
			variable(temp[0], true);
			doIncop = false;
		}
		else if(temp[1]->getType() == "DECOP") {
			codeasm << "\t;Line no " << temp[1]->getRuleStartLine() << " variable DECOP\n";
			doDecop = true;
			variable(temp[0], true);
			doDecop = false;
		}
	}
	else if(temp[1]->getType() == "expression") {
		codeasm << "\t;Line no " << temp[1]->getRuleStartLine() << " expression\n";
		expression(temp[1]);
		codeasm << "\tPOP AX\n";
	}
	else if(temp[0]->getType() == "ID") {
		codeasm << "\t;Line no " << temp[0]->getRuleStartLine() << temp[0]->getName() << " function call\n";
		argument_list(temp[2]);
		SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable(temp[0]->getName());
		if(finder == NULL) {
			errorCount++;
			cout << "Undefined function\n";
		}
		else {
			codeasm << "\tCALL " << temp[0]->getName() << '\n';
		}
	}
	codeasm << "\tPUSH AX\n";
}

void argument_list(SymbolInfo *argument_list_si) {
	if(argument_list_si->getParseTreeChildList().size()) {
		arguments(argument_list_si->getParseTreeChildList()[0]);
	}
}

void arguments(SymbolInfo *arguments_si) {
	vector<SymbolInfo *> temp = arguments_si->getParseTreeChildList();
	if(temp[0]->getType() == "logic_expression") {
		logic_expression(temp[0]);
	}
	else {
		logic_expression(temp[2]);
		arguments(temp[0]);
	}
}


int main(int argc,char *argv[])
{

	FILE *fp;

	if((fp=fopen(argv[1],"r"))==NULL)
	{
		printf("Cannot Open Input File.\n");
		exit(1);
	}

	parseTree.open(argv[2]);
	errorOut.open(argv[3]);
	logOut.open(argv[4]);
	codeasm.open(argv[5]);
	optcodeasm.open(argv[6]);
	

	yyin=fp;

	symbolTable->enterScope(scopeTableCounter, num_of_buckets);


	yyparse();

	
	scopeTableCounter = 1;
	start(startSymbol);

	delete symbolTable;

	logOut << "Total Lines: " << lineCount << '\n';
    logOut << "Total Errors: " << errorCount << '\n';

	logOut.close();
	errorOut.close();
	parseTree.close();
	codeasm.close();
	unoptcodeasm.open(argv[5]);
	optimize(unoptcodeasm, optcodeasm);
	unoptcodeasm.close();
	optcodeasm.close();

	fclose(fp);
	
	return 0;
}
