
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ASSIGN = 258,
     PLUS = 259,
     MINUS = 260,
     MULT = 261,
     DIV = 262,
     LPAREN = 263,
     RPAREN = 264,
     POW = 265,
     GT = 266,
     LT = 267,
     GE = 268,
     LE = 269,
     EQUALS = 270,
     NE = 271,
     HEAD = 272,
     TAIL = 273,
     WHINNY = 274,
     NEWLINE = 275,
     NOT = 276,
     MOD = 277,
     WHOA = 278,
     END = 279,
     STRING = 280,
     IDENTIFIER = 281,
     REALNUMBER = 282,
     MONEY = 283,
     FLOAT = 284,
     BIGNUM = 285
   };
#endif
/* Tokens.  */
#define ASSIGN 258
#define PLUS 259
#define MINUS 260
#define MULT 261
#define DIV 262
#define LPAREN 263
#define RPAREN 264
#define POW 265
#define GT 266
#define LT 267
#define GE 268
#define LE 269
#define EQUALS 270
#define NE 271
#define HEAD 272
#define TAIL 273
#define WHINNY 274
#define NEWLINE 275
#define NOT 276
#define MOD 277
#define WHOA 278
#define END 279
#define STRING 280
#define IDENTIFIER 281
#define REALNUMBER 282
#define MONEY 283
#define FLOAT 284
#define BIGNUM 285




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 29 "horse.y"

   int number; 
   float money;
   float floaty;
   char *string;		



/* Line 1676 of yacc.c  */
#line 121 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


