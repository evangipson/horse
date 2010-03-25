%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
int yywrap();
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
[+-]?{DIGIT}+"."+{DIGIT}+ {yylval.floaty = atof(yytext); return FLOAT; }
"#"[+-]?{DIGIT}+ { yylval.number = atoi(yytext); return BIGNUM; }
"$"[+-]?{DIGIT}{DIGIT}{DIGIT}"."{DIGIT}{DIGIT}{DIGIT} { yylval.money = atof(yytext); return MONEY; }
[a-zA-Z]+([a-zA-Z0-9])* { yylval.string = strdup(yytext); return IDENTIFIER; }
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
 
int yywrap() { return(0); }
