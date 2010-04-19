%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
#include "symbol.h"
int yywrap();
int lookup(char *);
int line_num = 0;
%}

DIGIT [0-9]
A [aA]
B [bB]
C [cC]
D [dD]
E [eE]
F [fF]
G [gG]
H [hH]
I [iI]
J [jJ]
K [kK]
L [lL]
M [mM]
N [nN]
O [oO]
P [pP]
Q [qQ]
R [rR]
S [sS]
T [tT]
U [uU]
V [vV]
W [wW]
X [xX]
Y [yY]
Z [zZ]
QUOTE \"
WS [ \t]+

%%

{H}{E}{A}{D} { return HEAD; }
{T}{A}{I}{L} { return TAIL; }
{W}{H}{I}{N}{N}{Y} {return WHINNY; }
{W}{H}{O}{A} {return WHOA; }
[+-]?{DIGIT}+ { yylval.number = atoi(yytext); return REALNUMBER; }
[+-]?{DIGIT}+"."+{DIGIT}+ {sscanf(yytext,"%f", &yylval.floaty); return FLOAT; }
"#"[+-]?{DIGIT}+ { yylval.number = atoi(yytext); return BIGNUM; }
"$"[+-]?{DIGIT}{DIGIT}{DIGIT}"."{DIGIT}{DIGIT}{DIGIT} { sscanf(yytext, "%f", &yylval.money); return MONEY; }
[a-zA-Z]+[a-zA-Z0-9]* { int type = 0; type = lookup(yytext); return type;}
"(" { return LPAREN; }
")" { return RPAREN; }
"<-" { return ASSIGN; }
"=" { return EQUALS; }
"<" { return LT; }
">" { return GT; }
">=" { return GE; }
"<=" { return LE; }
"<>" { return NE; }
"+" { return PLUS;}
"-" {return MINUS; }
"*" {return MULT; }
"/" {return DIV; }
"**" {return POW; }
"^" {return NOT; }
"%" {return MOD; }
"\n" { line_num = line_num + 1; return NEWLINE; }
{QUOTE}[a-zA-Z0-9 ?!@#$%^&*()-+~,'<>=]+{QUOTE} {yylval.string = strdup(yytext); return STRING; }
{WS} ;
"~"[ \t\r\n]* ;

%%
int lookup(char *value)
{
   //look stuff up in the symbol table.
   int i = 0;
   int value2;
   for(i; i < 100; i++)
   {
      if (symbolTable[i].id != NULL)
      {
        value2 = strcmp(symbolTable[i].id, value);
        if (value2 == 0)
        { 
          switch(symbolTable[i].type)
          {
            case 0 : yylval.string = strdup(yytext); return REALID;
	    case 1 : yylval.string = strdup(yytext); return FLOATID;
            case 2 : yylval.string = strdup(yytext); return STRINGID;
          }
        }
      }  
   }
   yylval.string = strdup(yytext);
   return BLANKID;
}

int yywrap() { return(0); }
