%{
#include <stdio.h>
extern int line_num;
%}

%token ASSIGN
%token PLUS
%token MINUS
%token MULT
%token DIV
%token LPAREN
%token RPAREN
%token POW
%token GT
%token LT
%token GE
%token LE
%token EQUALS
%token NE
%token HEAD
%token TAIL
%token WHINNY
%token NEWLINE
%token NOT
%token MOD
%token WHOA
%token END
%union
{
   int number; 
   float money;
   float floaty;
   char *string;		
}
%token <string> STRING
%token <string> IDENTIFIER
%token <number> REALNUMBER
%token <money> MONEY
%token <floaty> FLOAT
%token <number> BIGNUM

%%
lines:  
    | lines line
;
line: statement NEWLINE { printf("Line %d compiled.\n", line_num); }
    | NEWLINE 
    | WHOA NEWLINE  {printf("Program compiled, with %d lines.\n", line_num - 1); return 0;}
;
statement: assign
    | write
    | eval
;
write: WHINNY expr// {printf("%d\n",$2);}
    | WHINNY string //{printf("%s\n", $2); }
    | WHINNY eval //{printf("evaluation\n"); }
;
assign: IDENTIFIER ASSIGN expr
    | IDENTIFIER ASSIGN string
;
eval: exp GE exp //{if ($1 >= $3){ fprintf(stdout, "True\n");}else{fprintf(stdout,"False\n");}}
    | exp LE exp
    | exp EQUALS exp
    | exp NE exp
    | exp GT exp
    | exp LT exp
;
expr: expr PLUS term// { $$ = $1 + $3; }
    | expr MINUS term //{ $$ = $1 - $3; } 
    | term 
;
term: term MULT factor //{ $$ = $1 * $3; }
    | term DIV factor //{ $$ = $1 / $3; }
    | term MOD factor //{ $$ = $1 % $3; }
    | factor 
;
factor: factor POW exp //{ $$ = mypow($1, $3); }
    | exp 
;
exp: LPAREN expr RPAREN //{ $$ = $2; }
    | REALNUMBER  
    | FLOAT  
    | MONEY 
    | BIGNUM 
    | IDENTIFIER 
;
string : string PLUS STRING// { strcat($1, $3); }
    | STRING 
;
%%
yyerror(char * str)
{
   fprintf(stdout, "syntax error on line %d.\n",line_num);
}
int mypow(int b, int p)
{
   int r = b;
   if(p == 0) r = 1;
   while(p > 1)
   {
      r = b * r;
      p--;
   }
   return r;
}
