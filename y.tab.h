/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IF = 258,
    ELSE = 259,
    FOR = 260,
    DO = 261,
    WHILE = 262,
    BREAK = 263,
    INT = 264,
    CHAR = 265,
    FLOAT = 266,
    DOUBLE = 267,
    VOID = 268,
    RETURN = 269,
    SWITCH = 270,
    CASE = 271,
    CONTINUE = 272,
    DEFAULT = 273,
    PRNTLN = 274,
    CONST_INT = 275,
    CONST_FLOAT = 276,
    ID = 277,
    ADDOP = 278,
    MULOP = 279,
    INCOP = 280,
    DECOP = 281,
    RELOP = 282,
    ASSIGNOP = 283,
    BITOP = 284,
    LOGICOP = 285,
    NOT = 286,
    LPAREN = 287,
    RPAREN = 288,
    LCURL = 289,
    RCURL = 290,
    LSQUARE = 291,
    RSQUARE = 292,
    COMMA = 293,
    SEMICOLON = 294,
    LOWER_THAN_ELSE = 295
  };
#endif
/* Tokens.  */
#define IF 258
#define ELSE 259
#define FOR 260
#define DO 261
#define WHILE 262
#define BREAK 263
#define INT 264
#define CHAR 265
#define FLOAT 266
#define DOUBLE 267
#define VOID 268
#define RETURN 269
#define SWITCH 270
#define CASE 271
#define CONTINUE 272
#define DEFAULT 273
#define PRNTLN 274
#define CONST_INT 275
#define CONST_FLOAT 276
#define ID 277
#define ADDOP 278
#define MULOP 279
#define INCOP 280
#define DECOP 281
#define RELOP 282
#define ASSIGNOP 283
#define BITOP 284
#define LOGICOP 285
#define NOT 286
#define LPAREN 287
#define RPAREN 288
#define LCURL 289
#define RCURL 290
#define LSQUARE 291
#define RSQUARE 292
#define COMMA 293
#define SEMICOLON 294
#define LOWER_THAN_ELSE 295

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 246 "1905118.y"

	SymbolInfo* symbolInfo;

#line 141 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
