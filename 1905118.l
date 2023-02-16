%option noyywrap

%x STATE_CHAR_LITERAL
%x STATE_STRING_LITERAL
%x STATE_SINGLE_LINE_COMMENT
%x STATE_MULT_LINE_COMMENT

%{

#include <bits/stdc++.h>
using namespace std;

#include "1905118_symbol_table.h"
#include "y.tab.h"

extern YYSTYPE yylval;

// stringType 0 means single line str, 1 means mult line str
int stringType = 0, newlinesInMult = 0;

string charLiteralOriginal, charLiteralInterpreted;

string stringLiteralOriginal, stringLiteralInterpreted;

string commentOriginal;

extern ofstream logOut;
extern ofstream errorOut;

extern int lineCount;
extern int errorCount;

string capitaliseString(string s) {
    for(char &ch : s) {
        ch = toupper(ch);
    }
    return s;
}

%}

WHITESPACE [ \f\r\t\v]+
DIGIT [0-9]
MODIFIED_ALPHABETS [_A-Za-z]
NEWLINE \r?\n
ID {MODIFIED_ALPHABETS}({MODIFIED_ALPHABETS}|{DIGIT})*
CONST_INT {DIGIT}+
EXPONENT [Ee][+-]?{CONST_INT}
FRAC_CONST ({CONST_INT}\.)|({CONST_INT}?\.{CONST_INT})
CONST_FLOAT ({CONST_INT}{EXPONENT})|({FRAC_CONST}{EXPONENT}?)

%%

{WHITESPACE} {}

{NEWLINE} {lineCount++;}

"if" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "IF");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return IF;
}

"else" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "ELSE");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return ELSE;
}

"for" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "FOR");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return FOR;
}

"do" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "DO");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return DO;
}

"while" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "WHILE");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return WHILE;
}

"break" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "BREAK");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return BREAK;
}

"int" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "INT");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return INT;
}

"char" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "CHAR");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return CHAR;
}

"float" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "FLOAT");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return FLOAT;
}

"double" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "DOUBLE");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return DOUBLE;
}

"void" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "VOID");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return VOID;
}

"return" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "RETURN");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return RETURN;
}

"switch" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "SWITCH");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return SWITCH;
}

"case" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "CASE");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return CASE;
}

"continue" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "CONTINUE");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return CONTINUE;
}

"default" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "DEFAULT");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return DEFAULT;
}

"println" {
    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "PRNTLN");
    symbolInfo->setRuleStartLine(lineCount);
    symbolInfo->setRuleEndLine(lineCount);
    symbolInfo->setLeafNodeStatus(true);
    yylval.symbolInfo = symbolInfo;
    logOut << "Line# " << lineCount << ": Token <" << capitaliseString(yytext) << "> Lexeme " << yytext <<" found\n";
    return PRNTLN;
}

{CONST_INT} {
                    // tokenOut << "<" << "CONST_INT" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "CONST_INT" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "CONST_INT");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    symbolInfo->setDataType("INT");
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "CONST_INT" << "> Lexeme " << yytext <<" found\n";
                    return CONST_INT;
                    // return CONST_INT;
}

{CONST_FLOAT} {
                    // tokenOut << "<" << "CONST_FLOAT" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "CONST_FLOAT" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "CONST_FLOAT");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    symbolInfo->setDataType("FLOAT");
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "CONST_FLOAT" << "> Lexeme " << yytext <<" found\n";
                    return CONST_FLOAT;
                    // return CONST_FLOAT;
}

{ID} {  
                    // need to insert to symtable
                    // tokenOut << "<" << "ID" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "ID" << "> Lexeme " << yytext <<" found\n";
                    // SymbolInfo *symbol = new SymbolInfo(yytext, "ID");
                    // if(symbolTable->insertSymbolInSymbolTable(symbol, logOut)) {
                    //     symbolTable->printAllScopeTables(logOut);
                    // }
                    // else {
                    //     delete symbol;
                    // }
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "ID");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "ID" << "> Lexeme " << yytext <<" found\n";
                    return ID;
                    // return ID;
}

"+"|"-" {
                    // tokenOut << "<" << "ADDOP" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "ADDOP" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "ADDOP");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "ADDOP" << "> Lexeme " << yytext <<" found\n";
                    return ADDOP;
                    // return ADDOP;
}

"*"|"/"|"%" {
                    // tokenOut << "<" << "MULOP" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "MULOP" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "MULOP");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "MULOP" << "> Lexeme " << yytext <<" found\n";
                    return MULOP;
                    // return MULOP;
}

"++" {
                    // tokenOut << "<" << "INCOP" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "INCOP" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "INCOP");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "INCOP" << "> Lexeme " << yytext <<" found\n";
                    return INCOP;
                    // return INCOP;
}

"--" {
                    // tokenOut << "<" << "INCOP" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "DECOP" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "DECOP");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "DECOP" << "> Lexeme " << yytext <<" found\n";
                    return DECOP;
                    // return DECOP;
}

"<"|"<="|">"|">="|"=="|"!=" {
                    // tokenOut << "<" << "RELOP" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "RELOP" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "RELOP");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "RELOP" << "> Lexeme " << yytext <<" found\n";
                    return RELOP;
                    // return RELOP;
}

"=" {
                    // tokenOut << "<" << "ASSIGNOP" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "ASSIGNOP" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "ASSIGNOP");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "ASSIGNOP" << "> Lexeme " << yytext <<" found\n";
                    return ASSIGNOP;
                    // return ASSIGNOP;
}

"&&"|"||" {
                    // tokenOut << "<" << "LOGICOP" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "LOGICOP" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "LOGICOP");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "LOGICOP" << "> Lexeme " << yytext <<" found\n";
                    return LOGICOP;
                    // return LOGICOP;
}

"&"|"|"|"^"|">>"|"<<" {
                    // tokenOut << "<" << "BITOP" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "BITOP" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "BITOP");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "BITOP" << "> Lexeme " << yytext <<" found\n";
                    return BITOP;
                    // return BITOP;
}

"!" {
                    // tokenOut << "<" << "NOT" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "NOT" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "NOT");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "NOT" << "> Lexeme " << yytext <<" found\n";
                    return NOT;
                    // return NOT;
}

"(" {
                    // tokenOut << "<" << "LPAREN" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "LPAREN" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "LPAREN");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "LPAREN" << "> Lexeme " << yytext <<" found\n";
                    return LPAREN;
                    // return LPAREN;
}

")" {
                    // tokenOut << "<" << "RPAREN" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "RPAREN" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "RPAREN");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "RPAREN" << "> Lexeme " << yytext <<" found\n";
                    return RPAREN;
                    // return RPAREN;
}

"{" {
                    // need to enter scope
                    // symbolTable->enterScope(scopeTableCounter++, num_of_buckets);
                    // tokenOut << "<" << "LCURL" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "LCURL" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "LCURL");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "LCURL" << "> Lexeme " << yytext <<" found\n";
                    return LCURL;
                    // return LCURL;
}

"}" {
                    // need to exit scope
                    // symbolTable->exitScope();
                    // tokenOut << "<" << "RCURL" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "RCURL" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "RCURL");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "RCURL" << "> Lexeme " << yytext <<" found\n";
                    return RCURL;
                    // return RCURL;
}

"[" {
                    // tokenOut << "<" << "LSQUARE" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "LSQUARE" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "LSQUARE");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "LSQUARE" << "> Lexeme " << yytext <<" found\n";
                    return LSQUARE;
                    // return LSQUARE;
}

"]" {
                    // tokenOut << "<" << "RSQUARE" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "RSQUARE" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "RSQUARE");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "RSQUARE" << "> Lexeme " << yytext <<" found\n";
                    return RSQUARE;
                    // return RSQUARE;
}

"," {
                    // tokenOut << "<" << "COMMA" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "COMMA" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "COMMA");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "COMMA" << "> Lexeme " << yytext <<" found\n";
                    return COMMA;
                    // return COMMA;
}

";" {
                    // tokenOut << "<" << "SEMICOLON" << ", " << yytext << ">\n";
                    // logOut << "Line# " << lineCount << ": Token <" << "SEMICOLON" << "> Lexeme " << yytext <<" found\n";
                    SymbolInfo* symbolInfo = new SymbolInfo(yytext, "SEMICOLON");
                    symbolInfo->setRuleStartLine(lineCount);
                    symbolInfo->setRuleEndLine(lineCount);
                    symbolInfo->setLeafNodeStatus(true);
                    yylval.symbolInfo = symbolInfo;
                    logOut << "Line# " << lineCount << ": Token <" << "SEMICOLON" << "> Lexeme " << yytext <<" found\n";
                    return SEMICOLON;
}

\' {
    charLiteralOriginal.clear();
    charLiteralInterpreted.clear();
    BEGIN STATE_CHAR_LITERAL;
}

<STATE_CHAR_LITERAL><<EOF>> {
    errorCount++;
    charLiteralOriginal = "'" + charLiteralOriginal;
    logOut << "Error at line# " << lineCount << ": UNFINISHED_CONST_CHAR " << charLiteralOriginal << '\n';
    BEGIN INITIAL;
}

<STATE_CHAR_LITERAL>\r?\n {
    errorCount++;
    charLiteralOriginal = "'" + charLiteralOriginal;
    logOut << "Error at line# " << lineCount << ": UNFINISHED_CONST_CHAR " << charLiteralOriginal << '\n';
    lineCount++;
    BEGIN INITIAL;
}

<STATE_CHAR_LITERAL>\' {
    charLiteralOriginal = "'" + charLiteralOriginal + "'";
    if(charLiteralInterpreted.size() == 0) {
        if(charLiteralOriginal == "'\0'") {
            // tokenOut << "<" << "CONST_CHAR" << ", " << charLiteralInterpreted << ">\n";
            logOut << "Line# " << lineCount << ": Token <" << "CONST_CHAR" << "> Lexeme " << charLiteralInterpreted <<" found\n";
        }
        else {
            errorCount++;
            logOut << "Error at line# " << lineCount << ": EMPTY_CONST_CHAR " << charLiteralOriginal << '\n';
        }
    }
    else if(charLiteralInterpreted.size() == 1) {
        // tokenOut << "<" << "CONST_CHAR" << ", " << charLiteralInterpreted << ">\n";
        logOut << "Line# " << lineCount << ": Token <" << "CONST_CHAR" << "> Lexeme " << charLiteralInterpreted <<" found\n";
    }
    else {
        errorCount++;
        logOut << "Error at line# " << lineCount << ": MULTICHAR_CONST_CHAR " << charLiteralOriginal << '\n';
    }
    BEGIN INITIAL;
}

<STATE_CHAR_LITERAL>\\\' {
    charLiteralOriginal += "\\\'";
    charLiteralInterpreted += "\'";
}

<STATE_CHAR_LITERAL>\\\" {
    charLiteralOriginal += "\\\"";
    charLiteralInterpreted += "\"";
}

<STATE_CHAR_LITERAL>\\n {
    charLiteralOriginal += "\\n";
    charLiteralInterpreted += "\n";
}

<STATE_CHAR_LITERAL>\\t {
    charLiteralOriginal += "\\t";
    charLiteralInterpreted += "\t";
}

<STATE_CHAR_LITERAL>\\\\ {
    charLiteralOriginal += "\\\\";
    charLiteralInterpreted += "\\";
}

<STATE_CHAR_LITERAL>\\a {
    charLiteralOriginal += "\\a";
    charLiteralInterpreted += "\a";
}

<STATE_CHAR_LITERAL>\\f {
    charLiteralOriginal += "\\f";
    charLiteralInterpreted += "\f";
}

<STATE_CHAR_LITERAL>\\r {
    charLiteralOriginal += "\\r";
    charLiteralInterpreted += "\r";
}

<STATE_CHAR_LITERAL>\\b {
    charLiteralOriginal += "\\b";
    charLiteralInterpreted += "\b";
}

<STATE_CHAR_LITERAL>\\v {
    charLiteralOriginal += "\\v";
    charLiteralInterpreted += "\v";
}

<STATE_CHAR_LITERAL>\\0 {
    charLiteralOriginal += "\\0";
    charLiteralInterpreted += "\0";
}

<STATE_CHAR_LITERAL>. {
    charLiteralOriginal += yytext[0];
    charLiteralInterpreted += yytext[0];
}

\" {
    stringLiteralOriginal.clear();
    stringLiteralInterpreted.clear();
    BEGIN STATE_STRING_LITERAL;
}

<STATE_STRING_LITERAL><<EOF>> {
    errorCount++;
    stringLiteralOriginal = "\"" + stringLiteralOriginal;
    logOut << "Error at line# " << lineCount + newlinesInMult << ": UNFINISHED_STRING " << stringLiteralOriginal << '\n';
    stringType = 0;
    newlinesInMult = 0;
    BEGIN INITIAL;
}

<STATE_STRING_LITERAL>\r?\n {
    errorCount++;
    stringLiteralOriginal = "\"" + stringLiteralOriginal;
    logOut << "Error at line# " << lineCount + newlinesInMult << ": UNFINISHED_STRING " << stringLiteralOriginal << '\n';
    lineCount += newlinesInMult + 1;
    stringType = 0;
    newlinesInMult = 0;
    BEGIN INITIAL;
}

<STATE_STRING_LITERAL>\\\r\n {
    stringType = 1;
    newlinesInMult++;
    stringLiteralOriginal += "\\\r\n";
}

<STATE_STRING_LITERAL>\\\n {
    stringType = 1;
    newlinesInMult++;
    stringLiteralOriginal += "\\\n";
}

<STATE_STRING_LITERAL>\\\' {
    stringLiteralOriginal += "\\\'";
    stringLiteralInterpreted += "\'";
}

<STATE_STRING_LITERAL>\\\" {
    stringLiteralOriginal += "\\\"";
    stringLiteralInterpreted += "\"";
}

<STATE_STRING_LITERAL>\\n {
    stringLiteralOriginal += "\\n";
    stringLiteralInterpreted += "\n";
}

<STATE_STRING_LITERAL>\\t {
    stringLiteralOriginal += "\\t";
    stringLiteralInterpreted += "\t";
}

<STATE_STRING_LITERAL>\\\\ {
    stringLiteralOriginal += "\\\\";
    stringLiteralInterpreted += "\\";
}

<STATE_STRING_LITERAL>\\a {
    stringLiteralOriginal += "\\a";
    stringLiteralInterpreted += "\a";
}

<STATE_STRING_LITERAL>\\f {
    stringLiteralOriginal += "\\f";
    stringLiteralInterpreted += "\f";
}

<STATE_STRING_LITERAL>\\r {
    stringLiteralOriginal += "\\r";
    stringLiteralInterpreted += "\r";
}

<STATE_STRING_LITERAL>\\b {
    stringLiteralOriginal += "\\b";
    stringLiteralInterpreted += "\b";
}

<STATE_STRING_LITERAL>\\v {
    stringLiteralOriginal += "\\v";
    stringLiteralInterpreted += "\v";
}

<STATE_STRING_LITERAL>\\0 {
    stringLiteralOriginal += "\\0";
    stringLiteralInterpreted += "\0";
}

<STATE_STRING_LITERAL>\" {
    stringLiteralOriginal = "\"" + stringLiteralOriginal + "\"";
    string STRING = (stringType == 0) ? "SINGLE LINE STRING" : "MULTI LINE STRING";
    // tokenOut << "<" << STRING << ", " << stringLiteralInterpreted << ">\n";
    logOut << "Line# " << lineCount << ": Token <" << STRING << "> Lexeme " << stringLiteralOriginal <<" found\n";
    lineCount += newlinesInMult;
    newlinesInMult = 0;
    stringType = 0;
    BEGIN INITIAL;
}

<STATE_STRING_LITERAL>. {
    stringLiteralOriginal += yytext[0];
    stringLiteralInterpreted += yytext[0];
}

"//" {
    commentOriginal.clear();
    commentOriginal += "//";
    newlinesInMult = 0;
    BEGIN STATE_SINGLE_LINE_COMMENT;
}


<STATE_SINGLE_LINE_COMMENT><<EOF>> {
    logOut << "Line# " << lineCount << ": Token <" << "SINGLE LINE COMMENT" << "> Lexeme " << commentOriginal <<" found\n";
    lineCount += newlinesInMult;
    newlinesInMult = 0;
    BEGIN INITIAL;
}

<STATE_SINGLE_LINE_COMMENT>\r?\n {
    newlinesInMult++;
    logOut << "Line# " << lineCount << ": Token <" << "SINGLE LINE COMMENT" << "> Lexeme " << commentOriginal <<" found\n";
    lineCount += newlinesInMult;
    newlinesInMult = 0;
    BEGIN INITIAL;
}

<STATE_SINGLE_LINE_COMMENT>\\\r\n {
    newlinesInMult++;
    commentOriginal += "\\\r\n";
}

<STATE_SINGLE_LINE_COMMENT>\\\n {
    newlinesInMult++;
    commentOriginal += "\\\n";
}


<STATE_SINGLE_LINE_COMMENT>\\ {
    commentOriginal += "\\";
}

<STATE_SINGLE_LINE_COMMENT>. {
    commentOriginal += yytext[0];
}

"/*" {
    commentOriginal.clear();
    commentOriginal += "/*";
    newlinesInMult = 0;
    BEGIN STATE_MULT_LINE_COMMENT;
}


<STATE_MULT_LINE_COMMENT><<EOF>> {
    errorCount++;
    lineCount += newlinesInMult;
    logOut << "Error at line# " << lineCount << ": UNFINISHED_COMMENT " << commentOriginal << "\n";
    newlinesInMult = 0;
    BEGIN INITIAL;
}

<STATE_MULT_LINE_COMMENT>\r\n {
    commentOriginal += "\r\n";
    newlinesInMult++;
}

<STATE_MULT_LINE_COMMENT>\n {
    commentOriginal += "\n";
    newlinesInMult++;
}

<STATE_MULT_LINE_COMMENT>"*/" {
    commentOriginal += "*/";
    logOut << "Line# " << lineCount << ": Token <" << "MULTI LINE COMMENT" << "> Lexeme " << commentOriginal <<" found\n";
    lineCount += newlinesInMult;
    newlinesInMult = 0;
    BEGIN INITIAL;
}

<STATE_MULT_LINE_COMMENT>. {
    commentOriginal += yytext[0];
}

(({CONST_INT}+\.{CONST_INT}*)|({CONST_INT}*\.{CONST_INT}+))\.({CONST_INT}*\.*)*{CONST_FLOAT}? {
    errorCount++;
    logOut << "Error at line# " << lineCount << ": TOO_MANY_DECIMAL_POINTS " << yytext << '\n';
    // return TOO_MANY_DECIMAL_POINTS;
}

(({CONST_INT}?\.{CONST_INT})|{CONST_INT})([Ee][+-]?){CONST_FLOAT} {
    errorCount++;
    logOut << "Error at line# " << lineCount << ": ILLFORMED_NUMBER " << yytext << '\n';
    // return ILLFORMED_NUMBER;
}

({CONST_INT}|{CONST_FLOAT})+{ID}+ {
    errorCount++;
    logOut << "Error at line# " << lineCount << ": INVALID_ID_SUFFIX_NUM_PREFIX " << yytext << '\n';
    // return INVALID_ID_SUFFIX_NUM_PREFIX;
}

. {
   errorCount++;
   logOut << "Error at line# " << lineCount << ": UNRECOGNIZED_CHAR " << yytext << '\n';
    // return UNRECOGNIZED_CHAR;
}

%%

// int main(int argc, char *argv[]) {
//     if(argc != 2) {
//         cout << "Please provide input file name and try again\n";
//         return 0;
//     }

//     FILE *inputFile = fopen(argv[1], "r");
//     if(inputFile == NULL) {
//         cout << "Cannot open specified file\n";
//         return 0;
//     }

//     tokenOut.open("1905118_token.txt");
//     logOut.open("1905118_log.txt");

//     symbolTable->enterScope(scopeTableCounter++, num_of_buckets);

//     yyin = inputFile;
//     yylex();
//     fclose(yyin);

//     symbolTable->printAllScopeTables(logOut);

    // logOut << "Total lines: " << lineCount << '\n';
    // logOut << "Total errors: " << errorCount << '\n';

//     delete symbolTable;

//     tokenOut.close();
//     logOut.close();

//     return 0;
// }