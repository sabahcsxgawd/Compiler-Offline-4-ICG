/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "1905118.y"

#include <bits/stdc++.h>
using namespace std;

#include "1905118_symbol_table.h"

int yyparse(void);
int yylex(void);
extern FILE *yyin;

ofstream logOut, errorOut, parseTree, codeasm;

int lineCount = 1, errorCount = 0, errorLine = 0, offsetForVar = 0, anotherOffset = 0, labelCount = 0;

bool isFunctionScope = false, isZeroVal = false, isError = false, doIncop = false, doDecop = false;

vector<SymbolInfo*> functionParameterList, variableDeclarationList;

uint64_t num_of_buckets = 11, scopeTableCounter = 1;

SymbolTable *symbolTable = new SymbolTable();

SymbolInfo *startSymbol, *func_def_test;

// map< pair<string, int>, SymbolInfo * > symbolMap;

string globalLabel = "";

string new_line_proc = "\n\
new_line proc\n\
    push ax\n\
    push dx\n\
    mov ah,2\n\
    mov dl,cr\n\
    int 21h\n\
    mov ah,2\n\
    mov dl,lf\n\
    int 21h\n\
    pop dx\n\
    pop ax\n\
    ret\n\
new_line endp\n\n";

string print_output_proc = "\n\
print_output proc  ;print what is in ax\n\
    push ax\n\
    push bx\n\
    push cx\n\
    push dx\n\
    push si\n\
    lea si,number\n\
    mov bx,10\n\
    add si,4\n\
    cmp ax,0\n\
    jnge negate\n\
    print:\n\
    xor dx,dx\n\
    div bx\n\
    mov [si],dl\n\
    add [si],'0'\n\
    dec si\n\
    cmp ax,0\n\
    jne print\n\
    inc si\n\
    lea dx,si\n\
    mov ah,9\n\
    int 21h\n\
    pop si\n\
    pop dx\n\
    pop cx\n\
    pop bx\n\
    pop ax\n\
    ret\n\
    negate:\n\
    push ax\n\
    mov ah,2\n\
    mov dl,'-'\n\
    int 21h\n\
    pop ax\n\
    neg ax\n\
    jmp print\n\
print_output endp\n";

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

void printAboutVarInASM(SymbolInfo *var, int varSize, bool mode) {
	string varName = var->getName();
	//TODOICG
	if(!mode) {
		codeasm << "\t" << varName << " DW " << varSize << " DUP (0000H)\n";
	}
	else {
		var->baseOffset = offsetForVar - 2;
		offsetForVar = offsetForVar - (2 * varSize);
		codeasm << "\tSUB SP, " << (2 * varSize) << '\n';
	}
}

string genLabel() {
	return "L" + to_string(++labelCount);
}



#line 319 "y.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
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
#line 250 "1905118.y"

	SymbolInfo* symbolInfo;

#line 455 "y.tab.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */



#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  11
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   155

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  41
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  32
/* YYNRULES -- Number of rules.  */
#define YYNRULES  75
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  133

#define YYUNDEFTOK  2
#define YYMAXUTOK   295


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   268,   268,   283,   292,   302,   310,   319,   329,   407,
     467,   467,   486,   486,   504,   512,   504,   540,   555,   570,
     583,   599,   599,   619,   619,   640,   685,   685,   712,   720,
     728,   738,   752,   769,   779,   796,   804,   816,   824,   832,
     840,   854,   866,   880,   892,   925,   937,   945,   954,   954,
     979,  1021,  1074,  1085,  1125,  1136,  1159,  1170,  1194,  1205,
    1240,  1251,  1323,  1342,  1361,  1374,  1390,  1466,  1483,  1497,
    1511,  1531,  1553,  1566,  1580,  1592
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "IF", "ELSE", "FOR", "DO", "WHILE",
  "BREAK", "INT", "CHAR", "FLOAT", "DOUBLE", "VOID", "RETURN", "SWITCH",
  "CASE", "CONTINUE", "DEFAULT", "PRNTLN", "CONST_INT", "CONST_FLOAT",
  "ID", "ADDOP", "MULOP", "INCOP", "DECOP", "RELOP", "ASSIGNOP", "BITOP",
  "LOGICOP", "NOT", "LPAREN", "RPAREN", "LCURL", "RCURL", "LSQUARE",
  "RSQUARE", "COMMA", "SEMICOLON", "LOWER_THAN_ELSE", "$accept", "start",
  "program", "unit", "func_declaration", "func_definition", "$@1", "$@2",
  "$@3", "$@4", "parameter_list", "compound_statement", "$@5", "$@6",
  "var_declaration", "$@7", "type_specifier", "declaration_list",
  "statements", "statement", "expression_statement", "$@8", "variable",
  "expression", "logic_expression", "rel_expression", "simple_expression",
  "term", "unary_expression", "factor", "argument_list", "arguments", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295
};
# endif

#define YYPACT_NINF (-84)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-24)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      21,   -84,   -84,   -84,    36,    21,   -84,   -84,   -84,   -84,
      19,   -84,   -84,   -84,   -26,    39,   -20,     2,    26,    29,
     -84,   -84,   -84,    -1,   -16,    37,    38,    43,    59,   -84,
      60,    63,    21,   -84,   -84,    62,   -84,    73,   -84,   -84,
      60,    91,    77,    60,    84,    82,   -84,   -84,   -84,   -84,
     -84,    87,    90,    97,   104,    98,   -84,   -84,    -8,   104,
     104,   104,   -84,   -84,   -84,    25,    49,   -84,   -84,    48,
      92,   -84,   102,    34,   109,   -84,   -84,   -84,    95,   104,
      89,   104,    99,   115,   104,   104,    75,   -84,   -84,   106,
     105,   -84,   -84,   -84,   -84,   104,   -84,   104,   104,   104,
     104,   -84,   107,    89,   110,   -84,   111,   -84,   112,   108,
     113,   -84,   -84,   -84,   109,   119,   -84,    84,   104,    84,
     114,   -84,   104,   -84,   143,   116,   -84,   -84,   -84,    84,
      84,   -84,   -84
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       0,    28,    29,    30,     0,     2,     4,     6,     7,     5,
       0,     1,     3,    26,    33,     0,     0,     0,     0,     0,
      25,    27,    14,    12,     0,    20,     0,    31,     0,     9,
       0,    10,     0,    19,    34,     0,    15,    21,    13,     8,
       0,    18,     0,     0,     0,     0,    11,    17,    32,    16,
      48,     0,     0,     0,     0,     0,    68,    69,    50,     0,
       0,     0,    46,    39,    37,     0,     0,    35,    38,    65,
       0,    52,    54,    56,    58,    60,    64,    24,     0,     0,
       0,     0,     0,     0,    73,     0,    65,    62,    63,     0,
      33,    22,    36,    70,    71,     0,    47,     0,     0,     0,
       0,    49,     0,     0,     0,    45,     0,    75,     0,    72,
       0,    67,    53,    55,    59,    57,    61,     0,     0,     0,
       0,    66,     0,    51,    41,     0,    43,    44,    74,     0,
       0,    42,    40
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -84,   -84,   -84,   146,   -84,   -84,   -84,   -84,   -84,   -84,
     -84,    56,   -84,   -84,    18,   -84,    16,   -84,   -84,   -64,
     -66,   -84,   -55,   -54,   -83,    51,    53,    57,   -51,   -84,
     -84,   -84
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     4,     5,     6,     7,     8,    40,    30,    28,    43,
      24,    63,    44,    45,    64,    16,    65,    15,    66,    67,
      68,    78,    69,    70,    71,    72,    73,    74,    75,    76,
     108,   109
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      82,   107,    92,    22,    86,    86,    17,    89,    87,    88,
      18,     1,   112,     2,   103,     3,    10,    31,     9,    21,
      13,    10,    32,     9,    84,   102,    13,   104,    85,    86,
       1,   110,     2,    25,     3,    23,    11,   118,    29,   128,
      86,    14,    86,    86,    86,    86,    26,    90,    41,   116,
      50,    27,    51,   124,    52,   126,    53,    98,     1,    33,
       2,    99,     3,    54,   125,   131,   132,    86,    55,    56,
      57,    58,    59,    93,    94,    34,    95,    19,    20,    35,
      60,    61,    42,    37,    91,    50,    38,    51,    62,    52,
      50,    53,    36,     1,    37,     2,    46,     3,    54,    49,
      93,    94,    39,    55,    56,    57,    58,    59,   -23,    56,
      57,    58,    59,    47,    48,    60,    61,    77,    37,    79,
      60,    61,    80,    62,    56,    57,    58,    59,    62,    81,
      83,    96,    97,   100,   101,    60,    61,   106,   105,   111,
     117,    18,    98,   119,   120,   121,   122,   129,   113,   130,
     123,    12,   115,   127,     0,   114
};

static const yytype_int16 yycheck[] =
{
      54,    84,    66,     1,    59,    60,    32,    61,    59,    60,
      36,     9,    95,    11,    80,    13,     0,    33,     0,    39,
       1,     5,    38,     5,    32,    79,     1,    81,    36,    84,
       9,    85,    11,    17,    13,    33,     0,   103,    39,   122,
      95,    22,    97,    98,    99,   100,    20,    22,    32,   100,
       1,    22,     3,   117,     5,   119,     7,    23,     9,    22,
      11,    27,    13,    14,   118,   129,   130,   122,    19,    20,
      21,    22,    23,    25,    26,    37,    28,    38,    39,    36,
      31,    32,    20,    34,    35,     1,    30,     3,    39,     5,
       1,     7,    33,     9,    34,    11,    40,    13,    14,    43,
      25,    26,    39,    19,    20,    21,    22,    23,    35,    20,
      21,    22,    23,    22,    37,    31,    32,    35,    34,    32,
      31,    32,    32,    39,    20,    21,    22,    23,    39,    32,
      32,    39,    30,    24,    39,    31,    32,    22,    39,    33,
      33,    36,    23,    33,    33,    33,    38,     4,    97,    33,
      37,     5,    99,    39,    -1,    98
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,     9,    11,    13,    42,    43,    44,    45,    46,    55,
      57,     0,    44,     1,    22,    58,    56,    32,    36,    38,
      39,    39,     1,    33,    51,    57,    20,    22,    49,    39,
      48,    33,    38,    22,    37,    36,    33,    34,    52,    39,
      47,    57,    20,    50,    53,    54,    52,    22,    37,    52,
       1,     3,     5,     7,    14,    19,    20,    21,    22,    23,
      31,    32,    39,    52,    55,    57,    59,    60,    61,    63,
      64,    65,    66,    67,    68,    69,    70,    35,    62,    32,
      32,    32,    64,    32,    32,    36,    63,    69,    69,    64,
      22,    35,    60,    25,    26,    28,    39,    30,    23,    27,
      24,    39,    64,    61,    64,    39,    22,    65,    71,    72,
      64,    33,    65,    66,    68,    67,    69,    33,    61,    33,
      33,    33,    38,    37,    60,    64,    60,    39,    65,     4,
      33,    60,    60
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    41,    42,    43,    43,    44,    44,    44,    45,    45,
      47,    46,    48,    46,    49,    50,    46,    51,    51,    51,
      51,    53,    52,    54,    52,    55,    56,    55,    57,    57,
      57,    58,    58,    58,    58,    59,    59,    60,    60,    60,
      60,    60,    60,    60,    60,    60,    61,    61,    62,    61,
      63,    63,    64,    64,    65,    65,    66,    66,    67,    67,
      68,    68,    69,    69,    69,    70,    70,    70,    70,    70,
      70,    70,    71,    71,    72,    72
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     1,     1,     6,     5,
       0,     7,     0,     6,     0,     0,     8,     4,     3,     2,
       1,     0,     4,     0,     3,     3,     0,     4,     1,     1,
       1,     3,     6,     1,     4,     1,     2,     1,     1,     1,
       7,     5,     7,     5,     5,     3,     1,     2,     0,     3,
       1,     4,     1,     3,     1,     3,     1,     3,     1,     3,
       1,     3,     2,     2,     1,     1,     4,     3,     1,     1,
       2,     2,     1,     0,     3,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYPTRDIFF_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2:
#line 269 "1905118.y"
        {
		//write your code in this block in all the similar blocks below
		logOut << "start : program" << '\n';
		(yyval.symbolInfo) = new SymbolInfo("program", "start");
		(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
        (yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
        (yyval.symbolInfo)->setLeafNodeStatus(false);
		(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
		printParseTree((yyval.symbolInfo), 0);
		// deleteParseTree($$);
		startSymbol = (yyval.symbolInfo);
	}
#line 1742 "y.tab.c"
    break;

  case 3:
#line 283 "1905118.y"
                       {
		logOut << "program : program unit " << '\n';
		(yyval.symbolInfo) = new SymbolInfo("program unit", "program");
		(yyval.symbolInfo)->setRuleStartLine((yyvsp[-1].symbolInfo)->getRuleStartLine());
        (yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
        (yyval.symbolInfo)->setLeafNodeStatus(false);
		(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
		(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
	}
#line 1756 "y.tab.c"
    break;

  case 4:
#line 292 "1905118.y"
               {
		logOut << "program : unit " << '\n';
		(yyval.symbolInfo) = new SymbolInfo("unit", "program");
		(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
        (yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
        (yyval.symbolInfo)->setLeafNodeStatus(false);
		(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
	}
#line 1769 "y.tab.c"
    break;

  case 5:
#line 302 "1905118.y"
                       {
		logOut << "unit : var_declaration" << '\n';
		(yyval.symbolInfo) = new SymbolInfo("var_declaration", "unit");
		(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
        (yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
        (yyval.symbolInfo)->setLeafNodeStatus(false);
		(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
	}
#line 1782 "y.tab.c"
    break;

  case 6:
#line 310 "1905118.y"
                        {
		logOut << "unit : func_declaration" << '\n';
		(yyval.symbolInfo) = new SymbolInfo("func_declaration", "unit");
		(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
        (yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
        (yyval.symbolInfo)->setLeafNodeStatus(false);
		(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

	 }
#line 1796 "y.tab.c"
    break;

  case 7:
#line 319 "1905118.y"
                       {
		logOut << "unit : func_definition" << '\n';
		(yyval.symbolInfo) = new SymbolInfo("func_definition", "unit");
		(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
        (yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
        (yyval.symbolInfo)->setLeafNodeStatus(false);
		(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
	 }
#line 1809 "y.tab.c"
    break;

  case 8:
#line 329 "1905118.y"
                                                                            {
					isFunctionScope = false;
					logOut << "func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("type_specifier ID LPAREN parameter_list RPAREN SEMICOLON", "func_declaration");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-5].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-5].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-4].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-3].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable((yyvsp[-4].symbolInfo)->getName());
					if(finder == NULL) {
						(yyvsp[-4].symbolInfo)->setDataType((yyvsp[-5].symbolInfo)->getName());
						(yyvsp[-4].symbolInfo)->setIsAFunction(true);
						(yyvsp[-4].symbolInfo)->setIsFunctionDeclared(true);
						for(SymbolInfo* s : functionParameterList) {
							(yyvsp[-4].symbolInfo)->addFunctionParameterToList(s);
						}
						SymbolInfo *s_temp = new SymbolInfo((yyvsp[-4].symbolInfo));
						symbolTable->insertSymbolInSymbolTable(s_temp, logOut);
						// symbolMap.insert(make_pair(make_pair($2->getName(), scopeTableCounter), $2));
					}
					else {
						(yyvsp[-4].symbolInfo)->setDataType((yyvsp[-5].symbolInfo)->getName());
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
						else if(finder->getDataType() == (yyvsp[-4].symbolInfo)->getDataType()) {
							vector<SymbolInfo *> v1, v2;
							v1 = finder->getFunctionParameterList();
							v2 = (yyvsp[-4].symbolInfo)->getFunctionParameterList();
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
#line 1892 "y.tab.c"
    break;

  case 9:
#line 407 "1905118.y"
                                                                             {
					isFunctionScope = false;
					logOut << "func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("type_specifier ID LPAREN RPAREN SEMICOLON", "func_declaration");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-4].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-4].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-3].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable((yyvsp[-3].symbolInfo)->getName());
					if(finder == NULL) {
						(yyvsp[-3].symbolInfo)->setDataType((yyvsp[-4].symbolInfo)->getName());
						(yyvsp[-3].symbolInfo)->setIsAFunction(true);
						(yyvsp[-3].symbolInfo)->setIsFunctionDeclared(true);					
						SymbolInfo *s_temp = new SymbolInfo((yyvsp[-3].symbolInfo));
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
						else if(finder->getDataType() == (yyvsp[-3].symbolInfo)->getDataType()) {
							vector<SymbolInfo *> v1, v2;
							v1 = finder->getFunctionParameterList();
							v2 = (yyvsp[-3].symbolInfo)->getFunctionParameterList();
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
#line 1955 "y.tab.c"
    break;

  case 10:
#line 467 "1905118.y"
                                                                 {
					tryToDefineFunction((yyvsp[-3].symbolInfo), (yyvsp[-4].symbolInfo)->getName());
					isFunctionScope = true;
				}
#line 1964 "y.tab.c"
    break;

  case 11:
#line 470 "1905118.y"
                                                     {
					logOut << "func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("type_specifier ID LPAREN parameter_list RPAREN compound_statement", "func_definition");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-6].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-6].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-5].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-4].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-3].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					functionParameterList.clear();
					isFunctionScope = false;
				}
#line 1985 "y.tab.c"
    break;

  case 12:
#line 486 "1905118.y"
                                                                  {
					tryToDefineFunction((yyvsp[-2].symbolInfo), (yyvsp[-3].symbolInfo)->getName());
					isFunctionScope = true;
				}
#line 1994 "y.tab.c"
    break;

  case 13:
#line 489 "1905118.y"
                                                     {
					logOut << "func_definition : type_specifier ID LPAREN RPAREN compound_statement" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("type_specifier ID LPAREN RPAREN compound_statement", "func_definition");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-5].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-5].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-4].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-3].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					functionParameterList.clear();
					isFunctionScope = false;				
				}
#line 2014 "y.tab.c"
    break;

  case 14:
#line 504 "1905118.y"
                                                                 {
					if(errorLine == 0 | isError) {
						errorCount++;
						errorOut << "Line# " << lineCount << ": Syntax error at parameter list of function definition\n";
						logOut << "Error at line no " << lineCount << " : syntax error\n";
						functionParameterList.clear();
						// isError = false;
						errorLine = lineCount;
					} }
#line 2028 "y.tab.c"
    break;

  case 15:
#line 512 "1905118.y"
                                                   {
						isError = false;
						errorLine = 0;
					}
#line 2037 "y.tab.c"
    break;

  case 16:
#line 515 "1905118.y"
                                                             {
						logOut << "func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement" << '\n';
						(yyval.symbolInfo) = new SymbolInfo("type_specifier ID LPAREN parameter_list RPAREN compound_statement", "func_definition");
						(yyval.symbolInfo)->setRuleStartLine((yyvsp[-7].symbolInfo)->getRuleStartLine());
						(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
						(yyval.symbolInfo)->setLeafNodeStatus(false);
						(yyval.symbolInfo)->addSymbolToList((yyvsp[-7].symbolInfo));
						(yyval.symbolInfo)->addSymbolToList((yyvsp[-6].symbolInfo));
						(yyval.symbolInfo)->addSymbolToList((yyvsp[-5].symbolInfo));
						SymbolInfo *s_temp = new SymbolInfo("error", "parameter_list");
						s_temp->setRuleStartLine((yyvsp[-5].symbolInfo)->getRuleStartLine());
						s_temp->setRuleEndLine((yyvsp[-2].symbolInfo)->getRuleEndLine());
						s_temp->setLeafNodeStatus(true);
						(yyval.symbolInfo)->addSymbolToList(s_temp);
						(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
						(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

						functionParameterList.clear();
						isFunctionScope = false;
						isError = false;
						errorLine = 0;						
				}
#line 2064 "y.tab.c"
    break;

  case 17:
#line 540 "1905118.y"
                                                         {
					logOut << "parameter_list  : parameter_list COMMA type_specifier ID" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("parameter_list COMMA type_specifier ID", "parameter_list");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-3].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-3].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					//need to set data type of ID
					(yyvsp[0].symbolInfo)->setDataType((yyvsp[-1].symbolInfo)->getName());
					functionParameterList.push_back((yyvsp[0].symbolInfo));
				}
#line 2084 "y.tab.c"
    break;

  case 18:
#line 555 "1905118.y"
                                                                      {
					logOut << "parameter_list : parameter_list COMMA type_specifier" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("parameter_list COMMA type_specifier", "parameter_list");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-2].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					//need to set data type of ID
					SymbolInfo *tempSymbol = new SymbolInfo("", "");
					tempSymbol->setDataType((yyvsp[0].symbolInfo)->getName());
					functionParameterList.push_back(tempSymbol);
				}
#line 2104 "y.tab.c"
    break;

  case 19:
#line 570 "1905118.y"
                                                    {
					logOut << "parameter_list  : type_specifier ID" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("type_specifier ID", "parameter_list");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-1].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					//need to set data type of ID
					(yyvsp[0].symbolInfo)->setDataType((yyvsp[-1].symbolInfo)->getName());
					functionParameterList.push_back((yyvsp[0].symbolInfo));
				}
#line 2122 "y.tab.c"
    break;

  case 20:
#line 583 "1905118.y"
                                                 {
					logOut << "parameter_list : type_specifier" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("type_specifier", "parameter_list");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					//need to set data type of ID
					SymbolInfo *tempSymbol = new SymbolInfo("", "");
					tempSymbol->setDataType((yyvsp[0].symbolInfo)->getName());
					functionParameterList.push_back(tempSymbol);
				}
#line 2140 "y.tab.c"
    break;

  case 21:
#line 599 "1905118.y"
                           {						
						symbolTable->enterScope(scopeTableCounter++, num_of_buckets);
						if(isFunctionScope) {
							tryToInsertParamsInSymbolTable();
							functionParameterList.clear();
						}
					}
#line 2152 "y.tab.c"
    break;

  case 22:
#line 605 "1905118.y"
                                                           {
						logOut << "compound_statement : LCURL statements RCURL" << '\n';
						(yyval.symbolInfo) = new SymbolInfo("LCURL statements RCURL", "compound_statement");
						(yyval.symbolInfo)->setRuleStartLine((yyvsp[-3].symbolInfo)->getRuleStartLine());
						(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
						(yyval.symbolInfo)->setLeafNodeStatus(false);
						(yyval.symbolInfo)->addSymbolToList((yyvsp[-3].symbolInfo));
						(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
						(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

						symbolTable->printAllScopeTables(logOut);
						symbolTable->exitScope();
						// scopeTableCounter--;
				   }
#line 2171 "y.tab.c"
    break;

  case 23:
#line 619 "1905118.y"
                                   {						
						symbolTable->enterScope(scopeTableCounter++, num_of_buckets);
						if(isFunctionScope) {
							tryToInsertParamsInSymbolTable();
							functionParameterList.clear();
						}
				   }
#line 2183 "y.tab.c"
    break;

  case 24:
#line 625 "1905118.y"
                                           {
						logOut << "compound_statement : LCURL RCURL" << '\n';
						(yyval.symbolInfo) = new SymbolInfo("LCURL RCURL", "compound_statement");
						(yyval.symbolInfo)->setRuleStartLine((yyvsp[-2].symbolInfo)->getRuleStartLine());
						(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
						(yyval.symbolInfo)->setLeafNodeStatus(false);
						(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
						(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

						symbolTable->printAllScopeTables(logOut);
						symbolTable->exitScope();
						// scopeTableCounter--;
				   }
#line 2201 "y.tab.c"
    break;

  case 25:
#line 640 "1905118.y"
                                                            {
					logOut << "var_declaration : type_specifier declaration_list SEMICOLON" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("type_specifier declaration_list SEMICOLON", "var_declaration");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-2].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
					

					if((yyvsp[-2].symbolInfo)->getName() == "VOID") {
						// TODO throw error that var cant be void type

						for(SymbolInfo *s : variableDeclarationList) {
							errorCount++;
							errorOut << "Line# " << lineCount << ": Variable or field '" << s->getName() << "' declared void\n";
						}		
					}

					else {
						// need to add the declared vars in an a list and set their type
						for(SymbolInfo *s : variableDeclarationList) {
							s->setDataType((yyvsp[-2].symbolInfo)->getName());
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
#line 2251 "y.tab.c"
    break;

  case 26:
#line 685 "1905118.y"
                                                       {
					if(isError) {
						// errorLine = lineCount;
						// errorOut << "Line# " << lineCount << ": Syntax error at declaration list of variable declaration\n";
						logOut << "Error at line no " << lineCount << " : syntax error\n";
					} }
#line 2262 "y.tab.c"
    break;

  case 27:
#line 690 "1905118.y"
                                                      {
						logOut << "var_declaration : type_specifier declaration_list SEMICOLON" << '\n';
						errorOut << "Line# " << lineCount << ": Syntax error at declaration list of variable declaration\n";
						errorCount++;
						(yyval.symbolInfo) = new SymbolInfo("type_specifier declaration_list SEMICOLON", "var_declaration");
						(yyval.symbolInfo)->setRuleStartLine((yyvsp[-3].symbolInfo)->getRuleStartLine());
						(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
						(yyval.symbolInfo)->setLeafNodeStatus(false);
						(yyval.symbolInfo)->addSymbolToList((yyvsp[-3].symbolInfo));
						SymbolInfo *s_temp = new SymbolInfo("error", "declaration_list");
						s_temp->setLeafNodeStatus(true);
						s_temp->setRuleStartLine(lineCount);
						s_temp->setRuleEndLine(lineCount);
						(yyval.symbolInfo)->addSymbolToList(s_temp);
						(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

						variableDeclarationList.clear();
						isError = false;
						errorLine = 0;
				}
#line 2287 "y.tab.c"
    break;

  case 28:
#line 712 "1905118.y"
                      {
					logOut << "type_specifier	: INT" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("INT", "type_specifier");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
				}
#line 2300 "y.tab.c"
    break;

  case 29:
#line 720 "1905118.y"
                                        {
					logOut << "type_specifier	: FLOAT" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("FLOAT", "type_specifier");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
				}
#line 2313 "y.tab.c"
    break;

  case 30:
#line 728 "1905118.y"
                                       {
					logOut << "type_specifier	: VOID" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("VOID", "type_specifier");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
				}
#line 2326 "y.tab.c"
    break;

  case 31:
#line 738 "1905118.y"
                                             {
					logOut << "declaration_list : declaration_list COMMA ID" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("declaration_list COMMA ID", "declaration_list");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-2].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					variableDeclarationList.push_back((yyvsp[0].symbolInfo));


				}
#line 2345 "y.tab.c"
    break;

  case 32:
#line 752 "1905118.y"
                                                                                       {
					logOut << "declaration_list : declaration_list COMMA ID LSQUARE CONST_INT RSQUARE" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("declaration_list COMMA ID LSQUARE CONST_INT RSQUARE", "declaration_list");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-5].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-5].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-4].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-3].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					(yyvsp[-3].symbolInfo)->setIsAnArray(true);
					(yyvsp[-3].symbolInfo)->setArraySize(stoi((yyvsp[-1].symbolInfo)->getName()));
					variableDeclarationList.push_back((yyvsp[-3].symbolInfo));
				 }
#line 2367 "y.tab.c"
    break;

  case 33:
#line 769 "1905118.y"
                                      {
					logOut << "declaration_list : ID" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("ID", "declaration_list");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
					// cout << $1->getName() << " global " << $1 << '\n';
					variableDeclarationList.push_back((yyvsp[0].symbolInfo));
				 }
#line 2382 "y.tab.c"
    break;

  case 34:
#line 779 "1905118.y"
                                                                {
					logOut << "declaration_list : ID LSQUARE CONST_INT RSQUARE" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("ID LSQUARE CONST_INT RSQUARE", "declaration_list");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-3].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-3].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					(yyvsp[-3].symbolInfo)->setIsAnArray(true);
					(yyvsp[-3].symbolInfo)->setArraySize(stoi((yyvsp[-1].symbolInfo)->getName()));
					variableDeclarationList.push_back((yyvsp[-3].symbolInfo));
				 }
#line 2402 "y.tab.c"
    break;

  case 35:
#line 796 "1905118.y"
                       {
					logOut << "statements : statement" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("statement", "statements");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
			}
#line 2415 "y.tab.c"
    break;

  case 36:
#line 804 "1905118.y"
                                          {
					logOut << "statements : statements statement" << '\n';
					(yyval.symbolInfo) = new SymbolInfo("statements statement", "statements");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-1].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
		   }
#line 2429 "y.tab.c"
    break;

  case 37:
#line 816 "1905118.y"
                            {
					logOut << "statement : var_declaration" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("var_declaration", "statement");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
		  }
#line 2442 "y.tab.c"
    break;

  case 38:
#line 824 "1905118.y"
                                         {
					logOut << "statement : expression_statement" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("expression_statement", "statement");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
		  }
#line 2455 "y.tab.c"
    break;

  case 39:
#line 832 "1905118.y"
                                       {
					logOut << "statement : compound_statement" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("compound_statement", "statement");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
		  }
#line 2468 "y.tab.c"
    break;

  case 40:
#line 840 "1905118.y"
                                                                                                     {
					logOut << "statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("FOR LPAREN expression_statement expression_statement expression RPAREN statement", "statement");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-6].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-6].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-5].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-4].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-3].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
		  }
#line 2487 "y.tab.c"
    break;

  case 41:
#line 854 "1905118.y"
                                                                                {
					logOut << "statement : IF LPAREN expression RPAREN statement" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("IF LPAREN expression RPAREN statement", "statement");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-4].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-4].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-3].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
		  }
#line 2504 "y.tab.c"
    break;

  case 42:
#line 866 "1905118.y"
                                                                         {
					logOut << "statement : IF LPAREN expression RPAREN statement ELSE statement" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("IF LPAREN expression RPAREN statement ELSE statement", "statement");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-6].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-6].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-5].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-4].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-3].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
		  }
#line 2523 "y.tab.c"
    break;

  case 43:
#line 880 "1905118.y"
                                                             {
					logOut << "statement : WHILE LPAREN expression RPAREN statement" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("WHILE LPAREN expression RPAREN statement", "statement");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-4].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-4].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-3].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
		  }
#line 2540 "y.tab.c"
    break;

  case 44:
#line 892 "1905118.y"
                                                      {
					logOut << "statement : PRNTLN LPAREN ID RPAREN SEMICOLON" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("PRNTLN LPAREN ID RPAREN SEMICOLON", "statement");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-4].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-4].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-3].symbolInfo));

					// need to lookup the id					
					SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable((yyvsp[-2].symbolInfo)->getName());					
					if(finder == NULL) {
						// TODO undecl id error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Undeclared variable '" << (yyvsp[-2].symbolInfo)->getName() << "'" << '\n';
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

					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
					
		  }
#line 2578 "y.tab.c"
    break;

  case 45:
#line 925 "1905118.y"
                                                {
					logOut << "statement : RETURN expression SEMICOLON" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("RETURN expression SEMICOLON", "statement");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-2].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
		  }
#line 2593 "y.tab.c"
    break;

  case 46:
#line 937 "1905118.y"
                                    {
							logOut << "expression_statement 	: SEMICOLON " << '\n';
							(yyval.symbolInfo) = new SymbolInfo("SEMICOLON", "expression_statement");
							(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
							(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
							(yyval.symbolInfo)->setLeafNodeStatus(false);
							(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
						}
#line 2606 "y.tab.c"
    break;

  case 47:
#line 945 "1905118.y"
                                                                       {
							logOut << "expression_statement : expression SEMICOLON 		 " << '\n';
							(yyval.symbolInfo) = new SymbolInfo("expression SEMICOLON", "expression_statement");
							(yyval.symbolInfo)->setRuleStartLine((yyvsp[-1].symbolInfo)->getRuleStartLine());
							(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
							(yyval.symbolInfo)->setLeafNodeStatus(false);
							(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
							(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));						
						}
#line 2620 "y.tab.c"
    break;

  case 48:
#line 954 "1905118.y"
                                                        {
							if(isError | errorLine == 0) {
								isError = false;
								errorLine = lineCount;
							} 
						}
#line 2631 "y.tab.c"
    break;

  case 49:
#line 959 "1905118.y"
                                                            {
							logOut << "expression_statement : expression SEMICOLON 		 " << '\n';
							errorOut << "Line# " << errorLine << ": Syntax error at expression of expression statement\n";
							errorCount++;
							(yyval.symbolInfo) = new SymbolInfo("expression SEMICOLON", "expression_statement");
							(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
							(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
							(yyval.symbolInfo)->setLeafNodeStatus(false);
							SymbolInfo *s_temp = new SymbolInfo("error", "expression");
							s_temp->setRuleStartLine(errorLine);
							s_temp->setRuleEndLine(errorLine);
							s_temp->setLeafNodeStatus(true);
							(yyval.symbolInfo)->addSymbolToList(s_temp);
							(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

							isError = false;
							errorLine = 0;
						}
#line 2654 "y.tab.c"
    break;

  case 50:
#line 979 "1905118.y"
              {
                    logOut << "variable : ID" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("ID", "variable");					
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);

					// need to lookup the id
					SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable((yyvsp[0].symbolInfo)->getName());
					if(finder == NULL) {
						// TODO undecl id error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Undeclared variable '" << (yyvsp[0].symbolInfo)->getName() << "'" << '\n';
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
						(yyval.symbolInfo)->setDataType(finder->getDataType());
						(yyval.symbolInfo)->setIsAnArray((yyvsp[0].symbolInfo)->getIsAnArray());
					}

					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));		

		 }
#line 2701 "y.tab.c"
    break;

  case 51:
#line 1021 "1905118.y"
                                                 {
                    logOut << "variable : ID LSQUARE expression RSQUARE" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("ID LSQUARE expression RSQUARE", "variable");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-3].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					
					SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable((yyvsp[-3].symbolInfo)->getName());
					if(finder == NULL) {
						// TODO undecl id error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Undeclared variable '" << (yyvsp[-3].symbolInfo)->getName() << "'" << '\n';
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
						(yyval.symbolInfo)->setDataType(finder->getDataType());
						(yyval.symbolInfo)->setIsAnArray(finder->getIsAnArray());
					}

					//need to check the arr indexing too --> must be int
					if((yyvsp[-1].symbolInfo)->getDataType() != "INT") {
						// TODO invalid arr indexing
						errorCount++;
						errorOut << "Line# " << lineCount << ": Array subscript is not an integer\n";
					}

					(yyval.symbolInfo)->addSymbolToList((yyvsp[-3].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
		 }
#line 2757 "y.tab.c"
    break;

  case 52:
#line 1074 "1905118.y"
                              {
                    logOut << "expression 	: logic_expression	 " << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("logic_expression", "expression");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					(yyval.symbolInfo)->setDataType((yyvsp[0].symbolInfo)->getDataType());
					(yyval.symbolInfo)->setIsAnArray((yyvsp[0].symbolInfo)->getIsAnArray());
		   }
#line 2773 "y.tab.c"
    break;

  case 53:
#line 1085 "1905118.y"
                                                        {		
                    logOut << "expression 	: variable ASSIGNOP logic_expression 		 " << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("variable ASSIGNOP logic_expression", "expression");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-2].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					// if($3->getDataType() == "VOID" || $3->getDataType() == "" || $1->getDataType() == "VOID" || $1->getDataType() == "") {
					if((yyvsp[0].symbolInfo)->getDataType() == "VOID" || (yyvsp[-2].symbolInfo)->getDataType() == "VOID") {
						// TODO void func cant be in expression
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";
					}
					else if((yyvsp[-2].symbolInfo)->getDataType() == "FLOAT" && (yyvsp[0].symbolInfo)->getDataType() == "INT") {
						// ok ; change int to float i gues
						(yyval.symbolInfo)->setDataType((yyvsp[-2].symbolInfo)->getDataType());
					}
					else if((yyvsp[-2].symbolInfo)->getDataType() == "INT" && (yyvsp[0].symbolInfo)->getDataType() == "FLOAT") {
						// TODO error/warning \
						floating point number is assigned to an integer type variable
						errorCount++;
						errorOut << "Line# " << lineCount << ": Warning: possible loss of data in assignment of FLOAT to INT" << '\n';
						(yyval.symbolInfo)->setDataType((yyvsp[-2].symbolInfo)->getDataType());
					}
					else if((yyvsp[-2].symbolInfo)->getDataType() != (yyvsp[0].symbolInfo)->getDataType() && (yyvsp[-2].symbolInfo)->getDataType() != "" && (yyvsp[0].symbolInfo)->getDataType() != "") {
						// TODO type mismatch error
					}
					else if((yyvsp[-2].symbolInfo)->getIsAnArray() != (yyvsp[0].symbolInfo)->getIsAnArray()) {
						errorCount++;
						errorOut << "Line# " << lineCount << ": Warning: wrong type cast" << '\n';
					}
					else {
						(yyval.symbolInfo)->setDataType((yyvsp[-2].symbolInfo)->getDataType());
					}
		   }
#line 2816 "y.tab.c"
    break;

  case 54:
#line 1125 "1905118.y"
                                  {
                    logOut << "logic_expression : rel_expression" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("rel_expression", "logic_expression");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					(yyval.symbolInfo)->setDataType((yyvsp[0].symbolInfo)->getDataType());
					(yyval.symbolInfo)->setIsAnArray((yyvsp[0].symbolInfo)->getIsAnArray());
				 }
#line 2832 "y.tab.c"
    break;

  case 55:
#line 1136 "1905118.y"
                                                                         {
					logOut << "logic_expression : rel_expression LOGICOP rel_expression" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("rel_expression LOGICOP rel_expression", "logic_expression");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-2].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					// if($1->getDataType() == "VOID" || $3->getDataType() == "VOID" || $1->getDataType() == "" || $3->getDataType() == "") {
					if((yyvsp[-2].symbolInfo)->getDataType() == "VOID" || (yyvsp[0].symbolInfo)->getDataType() == "VOID") {
						// TODO VOID in logicop cant happen
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";
					}
					else {
						(yyval.symbolInfo)->setDataType("INT");
					}
					
				 }
#line 2858 "y.tab.c"
    break;

  case 56:
#line 1159 "1905118.y"
                                    {
                    logOut << "rel_expression	: simple_expression" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("simple_expression", "rel_expression");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					(yyval.symbolInfo)->setDataType((yyvsp[0].symbolInfo)->getDataType());
					(yyval.symbolInfo)->setIsAnArray((yyvsp[0].symbolInfo)->getIsAnArray());
				}
#line 2874 "y.tab.c"
    break;

  case 57:
#line 1170 "1905118.y"
                                                                                {
                    logOut << "rel_expression	: simple_expression RELOP simple_expression" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("simple_expression RELOP simple_expression", "rel_expression");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-2].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					if((yyvsp[-2].symbolInfo)->getDataType() == "VOID" || (yyvsp[0].symbolInfo)->getDataType() == "VOID") {
						// TODO void func in relop nonon
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";
					}
					else if((yyvsp[-2].symbolInfo)->getDataType() == "" || (yyvsp[0].symbolInfo)->getDataType() == "") {
						// TODO error 
					}
					else {
						(yyval.symbolInfo)->setDataType("INT");
					}
				}
#line 2901 "y.tab.c"
    break;

  case 58:
#line 1194 "1905118.y"
                         {
                    logOut << "simple_expression : term" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("term", "simple_expression");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					(yyval.symbolInfo)->setDataType((yyvsp[0].symbolInfo)->getDataType());
					(yyval.symbolInfo)->setIsAnArray((yyvsp[0].symbolInfo)->getIsAnArray());
				  }
#line 2917 "y.tab.c"
    break;

  case 59:
#line 1205 "1905118.y"
                                                                 {
                    logOut << "simple_expression : simple_expression ADDOP term" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("simple_expression ADDOP term", "simple_expression");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-2].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					// if($1->getDataType() == "VOID" || $3->getDataType() == "VOID" || $1->getDataType() == "" || $3->getDataType() == "") {
					if((yyvsp[-2].symbolInfo)->getDataType() == "VOID" || (yyvsp[0].symbolInfo)->getDataType() == "VOID") {
						// TODO error void func in simple_expression
						// TODO void func cant be in expression
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";
					}

					else {
						if((yyvsp[-2].symbolInfo)->getDataType() == "INT" || (yyvsp[0].symbolInfo)->getDataType() == "INT") {
							(yyval.symbolInfo)->setDataType((yyvsp[-2].symbolInfo)->getDataType());
						}
						else if((yyvsp[-2].symbolInfo)->getDataType() == "FLOAT" || (yyvsp[0].symbolInfo)->getDataType() == "INT") {
							(yyval.symbolInfo)->setDataType((yyvsp[-2].symbolInfo)->getDataType());
						}
						else if((yyvsp[-2].symbolInfo)->getDataType() == "INT" || (yyvsp[0].symbolInfo)->getDataType() == "FLOAT") {
							(yyval.symbolInfo)->setDataType((yyvsp[0].symbolInfo)->getDataType());
						}
						else {
							// TODO error
						}
					}
				  }
#line 2955 "y.tab.c"
    break;

  case 60:
#line 1240 "1905118.y"
                         {
                    logOut << "term :	unary_expression" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("unary_expression", "term");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					(yyval.symbolInfo)->setDataType((yyvsp[0].symbolInfo)->getDataType());
					(yyval.symbolInfo)->setIsAnArray((yyvsp[0].symbolInfo)->getIsAnArray());
	 }
#line 2971 "y.tab.c"
    break;

  case 61:
#line 1251 "1905118.y"
                                    {
                    logOut << "term :	term MULOP unary_expression" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("term MULOP unary_expression", "term");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-2].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					if((yyvsp[-2].symbolInfo)->getDataType() == "VOID" || (yyvsp[0].symbolInfo)->getDataType() == "VOID") {
						// TODO void func error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";
					}
				
					if((yyvsp[-1].symbolInfo)->getName() == "%") {
						// operands of mod op must be ints
						// also need to check for div by zero	
						if((yyvsp[-2].symbolInfo)->getDataType() == "INT" && (yyvsp[0].symbolInfo)->getDataType() == "INT") {
							if(isZeroVal) {
							// TODO mod by zero error
							errorCount++;
							errorOut << "Line# " << lineCount << ": Warning: division by zero" << '\n';
							}	
							else {
								(yyval.symbolInfo)->setDataType("INT");
							}
						}
						else {
							// TODO mod ops not int error
							errorCount++;
							errorOut << "Line# " << lineCount << ": Operands of modulus must be integers " << '\n';
						}
					}
					else if((yyvsp[-1].symbolInfo)->getName() == "/") {
						if(((yyvsp[-2].symbolInfo)->getDataType() == "INT" || (yyvsp[-2].symbolInfo)->getDataType() == "FLOAT") && ((yyvsp[0].symbolInfo)->getDataType() == "INT" || (yyvsp[0].symbolInfo)->getDataType() == "FLOAT")) {
							if(isZeroVal) {
								// TODO div by zero error
								errorCount++;
								errorOut << "Line# " << lineCount << ": Warning: division by zero" << '\n';
							}
							else {
								if((yyvsp[-2].symbolInfo)->getDataType() == "FLOAT" || (yyvsp[0].symbolInfo)->getDataType() == "FLOAT") {
									(yyval.symbolInfo)->setDataType("FLOAT");
								}
								else {
									(yyval.symbolInfo)->setDataType("INT");
								}
							}
						}
						else {
							// TODO void func error in exprssn
						}
					}
					else {
						if(((yyvsp[-2].symbolInfo)->getDataType() == "INT" || (yyvsp[-2].symbolInfo)->getDataType() == "FLOAT") && ((yyvsp[0].symbolInfo)->getDataType() == "INT" || (yyvsp[0].symbolInfo)->getDataType() == "FLOAT")) {
							if((yyvsp[-2].symbolInfo)->getDataType() == "FLOAT" || (yyvsp[0].symbolInfo)->getDataType() == "FLOAT") {
								(yyval.symbolInfo)->setDataType("FLOAT");
							}
							else {
								(yyval.symbolInfo)->setDataType("INT");
							}
						}
						else {
							// TODO void func error in exprssn
						}
					}
					isZeroVal = false;
	 }
#line 3046 "y.tab.c"
    break;

  case 62:
#line 1323 "1905118.y"
                                          {
                    logOut << "unary_expression : ADDOP unary_expression" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("ADDOP unary_expression", "unary_expression");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-1].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					// if($2->getDataType() == "VOID" || $2->getDataType() == "") {
					if((yyvsp[0].symbolInfo)->getDataType() == "VOID") {
						// TODO void func in exprssn error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";
					}
					else {
						(yyval.symbolInfo)->setDataType((yyvsp[0].symbolInfo)->getDataType());
					}
				 }
#line 3070 "y.tab.c"
    break;

  case 63:
#line 1342 "1905118.y"
                                                        {
                    logOut << "unary_expression : NOT unary_expression" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("NOT unary_expression", "unary_expression");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-1].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					// if($2->getDataType() == "VOID" || $2->getDataType() == "") {
					if((yyvsp[0].symbolInfo)->getDataType() == "VOID") {
						// TODO void func in exprssn error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";
					}
					else {
						(yyval.symbolInfo)->setDataType("INT");
					}
				 }
#line 3094 "y.tab.c"
    break;

  case 64:
#line 1361 "1905118.y"
                                          {
                    logOut << "unary_expression : factor" << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("factor", "unary_expression");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					(yyval.symbolInfo)->setDataType((yyvsp[0].symbolInfo)->getDataType());
					(yyval.symbolInfo)->setIsAnArray((yyvsp[0].symbolInfo)->getIsAnArray());
				 }
#line 3110 "y.tab.c"
    break;

  case 65:
#line 1374 "1905118.y"
                   {
                    logOut << "factor	: variable " << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("variable", "factor");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					if((yyvsp[0].symbolInfo)->getDataType() == "VOID" || (yyvsp[0].symbolInfo)->getDataType() == "") {
						// TODO void func in var error
					}
					else {
						(yyval.symbolInfo)->setDataType((yyvsp[0].symbolInfo)->getDataType());
						(yyval.symbolInfo)->setIsAnArray((yyvsp[0].symbolInfo)->getIsAnArray());
					}
		}
#line 3131 "y.tab.c"
    break;

  case 66:
#line 1390 "1905118.y"
                                                 {
                    logOut << "factor	: ID LPAREN argument_list RPAREN " << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("ID LPAREN argument_list RPAREN", "factor");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-3].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);					

					SymbolInfo *finder = symbolTable->lookUpSymbolInSymbolTable((yyvsp[-3].symbolInfo)->getName());
					if(finder == NULL) {
						// TODO func not defined err
						errorCount++;
						errorOut << "Line# " << lineCount << ": Undeclared function '" << (yyvsp[-3].symbolInfo)->getName() << "'" << '\n';
					}
					else {						
						(yyval.symbolInfo)->setDataType(finder->getDataType());						
						if(!(finder->getIsAFunction())) {
							// TODO not a func error
							// errorOut << "gege\n";
							errorCount++;
							errorOut << "Line# " << lineCount << ": Conflicting types for '" << (yyvsp[-3].symbolInfo)->getName() << "'" << '\n';
						}
						else if(!(finder->getIsFunctionDefined())) {
							// TODO func not defined
							errorCount++;
							errorOut << "Line# " << lineCount << ": Undefined function '" << (yyvsp[-3].symbolInfo)->getName() << "'" << '\n';
						}
						else {
							// need to check param length and types
							vector<SymbolInfo *> v1, v2;
							v1 = finder->getFunctionParameterList();
							v2 = (yyvsp[-1].symbolInfo)->getFunctionParameterList();
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
									(yyval.symbolInfo)->setDataType(finder->getDataType());
								}
								else {
									// TODO conflicting types error maybe
								}
							}
						}						
					}
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-3].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));
		}
#line 3212 "y.tab.c"
    break;

  case 67:
#line 1466 "1905118.y"
                                           {
                    logOut << "factor	: LPAREN expression RPAREN " << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("LPAREN expression RPAREN", "factor");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-2].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					if((yyvsp[-1].symbolInfo)->getDataType() == "VOID" || (yyvsp[-1].symbolInfo)->getDataType() == "") {
						// TODO void func in var error
					}
					else {
						(yyval.symbolInfo)->setDataType((yyvsp[-1].symbolInfo)->getDataType());
					}
		}
#line 3234 "y.tab.c"
    break;

  case 68:
#line 1483 "1905118.y"
                            {
                    logOut << "factor	: CONST_INT " << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("CONST_INT", "factor");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					(yyval.symbolInfo)->setDataType("INT");
					int temp = stoi((yyvsp[0].symbolInfo)->getName());
					if(temp == 0) {
						isZeroVal = true;
					}
		}
#line 3253 "y.tab.c"
    break;

  case 69:
#line 1497 "1905118.y"
                              {
                    logOut << "factor	: CONST_FLOAT " << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("CONST_FLOAT", "factor");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					(yyval.symbolInfo)->setDataType("FLOAT");
					float temp = stof((yyvsp[0].symbolInfo)->getName());
					if(temp == 0) {
						isZeroVal = true;
					}
		}
#line 3272 "y.tab.c"
    break;

  case 70:
#line 1511 "1905118.y"
                                 {
                    logOut << "factor	: variable INCOP " << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("variable INCOP", "factor");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-1].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					// if($1->getDataType() == "VOID" || $1->getDataType() == "") {
					if((yyvsp[-1].symbolInfo)->getDataType() == "VOID") {
						// TODO void func in var error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";

					}
					else {
						(yyval.symbolInfo)->setDataType((yyvsp[-1].symbolInfo)->getDataType());
					}
		}
#line 3297 "y.tab.c"
    break;

  case 71:
#line 1531 "1905118.y"
                                 {
                    logOut << "factor	: variable DECOP " << '\n';
                    (yyval.symbolInfo) = new SymbolInfo("variable DECOP", "factor");
					(yyval.symbolInfo)->setRuleStartLine((yyvsp[-1].symbolInfo)->getRuleStartLine());
					(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
					(yyval.symbolInfo)->setLeafNodeStatus(false);
					(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
					(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

					// if($1->getDataType() == "VOID" || $1->getDataType() == "") {
					if((yyvsp[-1].symbolInfo)->getDataType() == "VOID") {
						// TODO void func in var error
						errorCount++;
						errorOut << "Line# " << lineCount << ": Void cannot be used in expression \n";

					}
					else {
						(yyval.symbolInfo)->setDataType((yyvsp[-1].symbolInfo)->getDataType());
					}
		}
#line 3322 "y.tab.c"
    break;

  case 72:
#line 1553 "1905118.y"
                          {
				logOut << "argument_list : arguments" << '\n';
				(yyval.symbolInfo) = new SymbolInfo("arguments", "argument_list");
				(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
				(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
				(yyval.symbolInfo)->setLeafNodeStatus(false);
				(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

				for(SymbolInfo *s : functionParameterList) {
					(yyval.symbolInfo)->addFunctionParameterToList(s);
				}
				functionParameterList.clear();	
			  }
#line 3340 "y.tab.c"
    break;

  case 73:
#line 1566 "1905118.y"
                            {
				logOut << "argument_list : " << '\n';
				(yyval.symbolInfo) = new SymbolInfo("", "argument_list");
				(yyval.symbolInfo)->setRuleStartLine(lineCount);
				(yyval.symbolInfo)->setRuleEndLine(lineCount);
				(yyval.symbolInfo)->setLeafNodeStatus(false);
				
				for(SymbolInfo *s : functionParameterList) {
					(yyval.symbolInfo)->addFunctionParameterToList(s);
				}
				functionParameterList.clear();	
			  }
#line 3357 "y.tab.c"
    break;

  case 74:
#line 1580 "1905118.y"
                                             {
				logOut << "arguments : arguments COMMA logic_expression" << '\n';
				(yyval.symbolInfo) = new SymbolInfo("arguments COMMA logic_expression", "arguments");
				(yyval.symbolInfo)->setRuleStartLine((yyvsp[-2].symbolInfo)->getRuleStartLine());
				(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
				(yyval.symbolInfo)->setLeafNodeStatus(false);
				(yyval.symbolInfo)->addSymbolToList((yyvsp[-2].symbolInfo));
				(yyval.symbolInfo)->addSymbolToList((yyvsp[-1].symbolInfo));
				(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

				functionParameterList.push_back((yyvsp[0].symbolInfo));
		  }
#line 3374 "y.tab.c"
    break;

  case 75:
#line 1592 "1905118.y"
                                 {
				logOut << "arguments : logic_expression" << '\n';
				(yyval.symbolInfo) = new SymbolInfo("logic_expression", "arguments");
				(yyval.symbolInfo)->setRuleStartLine((yyvsp[0].symbolInfo)->getRuleStartLine());
				(yyval.symbolInfo)->setRuleEndLine((yyvsp[0].symbolInfo)->getRuleEndLine());
				(yyval.symbolInfo)->setLeafNodeStatus(false);
				(yyval.symbolInfo)->addSymbolToList((yyvsp[0].symbolInfo));

				functionParameterList.push_back((yyvsp[0].symbolInfo));
		  }
#line 3389 "y.tab.c"
    break;


#line 3393 "y.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[+*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 1605 "1905118.y"


void start(SymbolInfo*);
void program(SymbolInfo*);
void unit(SymbolInfo*);
void var_declaration(SymbolInfo*, bool);
void declaration_list(SymbolInfo*, bool);
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
		/* var_declaration(temp, false); */
	}
	if(temp->getType() == "func_definition") {
		func_definition(temp);
	}
}

void var_declaration(SymbolInfo* var_declaration_si, bool mode) {
	SymbolInfo *type_specifier_si = var_declaration_si->getParseTreeChildList()[0];
	SymbolInfo *declaration_list_si = var_declaration_si->getParseTreeChildList()[1];
	if(type_specifier_si->getName() == "INT") {
		declaration_list(declaration_list_si, mode);
	}
}

void declaration_list(SymbolInfo* declaration_list_si, bool mode) {
	vector<SymbolInfo*> tempList = declaration_list_si->getParseTreeChildList();
	if(tempList[0]->getType() == "declaration_list") {
		if(tempList.size() == 3) {
			declaration_list(tempList[0], mode);
			SymbolInfo *finder = NULL;
			if(symbolTable->insertSymbolInSymbolTable(tempList[2], logOut) && scopeTableCounter > 1) {
				finder = symbolTable->lookUpSymbolInSymbolTable(tempList[2]->getName());
				printAboutVarInASM(finder, 1, mode);
			}
			else {
				errorCount++;
				cout << "Error in declaration list\n";
			}			
		}
		else {
			declaration_list(tempList[0], mode);
			SymbolInfo *finder = NULL;
			if(symbolTable->insertSymbolInSymbolTable(tempList[2], logOut) && scopeTableCounter > 1) {
				finder = symbolTable->lookUpSymbolInSymbolTable(tempList[2]->getName());
				printAboutVarInASM(finder, stoi(tempList[4]->getName()), mode);
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
			if(symbolTable->insertSymbolInSymbolTable(tempList[0], logOut) && scopeTableCounter > 1) {
				finder = symbolTable->lookUpSymbolInSymbolTable(tempList[0]->getName());
				printAboutVarInASM(finder, 1, mode);
			}
			else {
				errorCount++;
				cout << "Error in declaration list\n";
			}					
		}
		else {	
			SymbolInfo *finder = NULL;
			if(symbolTable->insertSymbolInSymbolTable(tempList[0], logOut) && scopeTableCounter > 1) {
				finder = symbolTable->lookUpSymbolInSymbolTable(tempList[0]->getName());
				printAboutVarInASM(finder, stoi(tempList[2]->getName()), mode);
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
	/* if(tempList[1]->getName() == "main") {
		codeasm << "MAIN PROC\n";
		codeasm << "\tMOV AX, @DATA\n";
		codeasm << "\tMOV DS, AX\n";
		codeasm << "\tPUSH BP\n";
		codeasm << "\tMOV BP, SP\n";
		if(tempList.size() == 5) {
			offsetForVar = 0;
			compound_statement(tempList[4]);
			codeasm << "\tADD SP, " << -offsetForVar << '\n';
			codeasm << "\tPOP BP\n";
			offsetForVar = 0;
		}
		else {
			//TODOICG
		}
		codeasm << "\tMOV AX, 4CH\n";
		codeasm << "\tINT 21H\n";
		codeasm << "MAIN ENDP\n";
		codeasm << print_output_proc;
		codeasm << new_line_proc;
	} */
	codeasm << temp[1]->getName() << " PROC\n";
	if(temp[1]->getName() == "main") {
		codeasm << "\tMOV AX, @DATA\n";
		codeasm << "\tMOV DS, AX\n";
	}
	codeasm << "\tPUSH BP\n";
	codeasm << "\tMOV BP, SP\n";

	if(temp.size() == 6) {
		functionParameterList.clear();
		parameter_list(temp[3]);
		compound_statement(temp[5]);
	}
	else {
		compound_statement(temp[4]);
	}

	codeasm << globalLabel << ":\n";
	codeasm << "\tADD SP, " << -offsetForVar << '\n';
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
		statements(compound_statement_si->getParseTreeChildList()[1]);
		symbolTable->exitScope();
	}
}

void statements(SymbolInfo* statements_si) {
	if(statements_si->getParseTreeChildList().size() == 1) {		
		statement(statements_si->getParseTreeChildList()[0]);
	}
	else {
		statements(statements_si->getParseTreeChildList()[0]);
		statement(statements_si->getParseTreeChildList()[1]);
	}
}

void statement(SymbolInfo* statement_si) {
	codeasm << genLabel() << ":\n";
	vector<SymbolInfo *> tempList = statement_si->getParseTreeChildList();
	if(tempList[0]->getType() == "var_declaration") {
		var_declaration(tempList[0], true);
	}
	else if(tempList[0]->getType() == "compound_statement") {
		compound_statement(tempList[0]);
	}
	else if(tempList[0]->getType() == "PRNTLN") {
		println(tempList[2]);
	}
	else if(tempList[0]->getType() == "expression_statement") {
		expression_statement(tempList[0]);
	}
	else if(tempList[0]->getType() == "IF") {
		if(tempList.size() == 5) {
			string label = genLabel();
			expression(tempList[2]);
			codeasm << "\tPOP AX\n";
			codeasm << "\tCMP AX, 0\n";
			codeasm << "\tJE " << label << '\n';
			statement(tempList[4]);
			codeasm << label << ":\n";
		}
		else {
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
		codeasm << "\tPUSH AX\n";
		if(finder->baseOffset == 0) {
		codeasm << "\tMOV AX, " << finder->getName() << '\n';
		}
		else {
			string sign = finder->baseOffset > 0 ? "+" : "";
			codeasm << "\tMOV AX, " << "[BP" << sign << finder->baseOffset << "]\n";
		}
		codeasm << "\tCALL print_output\n";
		codeasm << "\tCALL new_line\n";
		codeasm << "\tPOP AX\n";
	}
}

void expression_statement(SymbolInfo* expression_statement_si) {
	if(expression_statement_si->getParseTreeChildList()[0]->getType() == "expression") {
		expression(expression_statement_si->getParseTreeChildList()[0]);
		codeasm << "\tPOP AX\n";
	}
}

void expression(SymbolInfo* expression_si) {
	vector<SymbolInfo*> temp = expression_si->getParseTreeChildList();
	if(temp[0]->getType() == "logic_expression") {
		logic_expression(temp[0]);
		codeasm << "\tPOP AX\n";
	}
	else if(temp[0]->getType() == "variable") {
		logic_expression(temp[2]);
		codeasm << "\tPOP AX\n";
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
			rel_expression(temp[0]);
			codeasm << "\tPOP AX\n";
		}
		else {
			rel_expression(temp[0]);
			rel_expression(temp[2]);
			codeasm << "\tPOP BX\n";
			codeasm << "\tPOP AX\n";
			string label1 = genLabel();
			string label2 = genLabel();
			if(temp[1]->getName() == "||") {
				codeasm << "\tCMP AX, 0\n";
				codeasm << "\tJNE " << label1 << '\n';
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
			simple_expression(temp[0]);
			codeasm << "\tPOP AX\n";
		}
		else {
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
		term(temp[0]);
	}
	else {
		simple_expression(temp[0]);
		term(temp[2]);
		codeasm << "\tPOP BX\n";
		codeasm << "\tPOP AX\n";
		if(temp[1]->getName() == "+") {
			codeasm << "\tADD AX, BX\n";
		}
		else {
			codeasm << "\tSUB AX, BX\n";
		}
		codeasm << "\tPUSH AX\n";
	}
}

void term(SymbolInfo* term_si) {
	vector<SymbolInfo*> temp = term_si->getParseTreeChildList();
	if(temp[0]->getType() == "unary_expression") {
		unary_expression(temp[0]);
	}
	else {
		term(temp[0]);
		unary_expression(temp[2]);
		codeasm << "\tPOP BX\n";
		codeasm << "\tPOP AX\n";

		codeasm << "\tCWD\n";
		if(temp[1]->getName() == "*") {
			codeasm << "\tIMUL BX\n";
		}
		else if(temp[1]->getName() == "/") {
			codeasm << "\tIDIV BX\n";
		}
		else if(temp[1]->getName() == "%") {
			codeasm << "\tIDIV BX\n";
			codeasm << "\tMOV AX, DX\n";
		}		
		codeasm << "\tPUSH AX\n";
	}	
}

void unary_expression(SymbolInfo* unary_expression_si) {
	vector<SymbolInfo*> temp = unary_expression_si->getParseTreeChildList();
	if(temp[0]->getType() == "factor") {
		factor(temp[0]);		
	}
	else {
		unary_expression(temp[1]);
		codeasm << "\tPOP AX\n";
		if(temp[0]->getName() == "-") {
			codeasm << "\tNEG AX\n";
		}
		else if(temp[0]->getName() == "!") {
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
		codeasm << "\tMOV AX, " << temp[0]->getName() << '\n';
	}
	else if(temp[0]->getType() == "variable") {
		if(temp.size() == 1) {
			variable(temp[0], true);
		}
		else if(temp[1]->getType() == "INCOP") {
			doIncop = true;
			variable(temp[0], true);
			doIncop = false;
		}
		else if(temp[1]->getType() == "DECOP") {
			doDecop = true;
			variable(temp[0], true);
			doDecop = false;
		}
	}
	else if(temp[1]->getType() == "expression") {
		expression(temp[1]);
		codeasm << "\tPOP AX\n";
	}
	else if(temp[0]->getType() == "ID") {
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

	fclose(fp);
	
	return 0;
}
