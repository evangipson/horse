%{
#include <stdio.h>
#include "symbol.h"
extern int line_num;
void lookup_table(char *);
struct symbol lookup_id(char *);
void table_insert(char *, struct symbol);
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
%token <string> REALID
%token <string> FLOATID
%token <string> STRINGID
%token <string> BLANKID
%token <number> REALNUMBER
%token <string> STRING
%token <floaty> FLOAT
%token <money> MONEY
%token <number> BIGNUM
%type <string> string
%type <number> rexpr
%type <string> id
//%type <money> mexpr
%type <floaty> fexpr
//%type <number> bexpr

%left PLUS MINUS 
%left MULT DIV MOD POW  //still need to implement this
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
   // | eval
;
write: WHINNY rexpr {printf("%d\n",$2);}
    | WHINNY fexpr {printf("%f\n", $2);}
    | WHINNY string {printf("%s\n", $2); }
    | WHINNY id {lookup_table($2);}
   // | WHINNY eval {printf("evaluation\n"); }
;
assign: id ASSIGN rexpr { newsymbol.id = $1; newsymbol.type = 0; newsymbol.value.real = $3; table_insert($1, newsymbol); } 
      | id ASSIGN fexpr { newsymbol.id = $1; newsymbol.type = 1; newsymbol.value.floaty = $3; table_insert($1, newsymbol); } 
      | id ASSIGN string { newsymbol.id = $1; newsymbol.type = 2; newsymbol.value.str = $3; table_insert($1, newsymbol); } 
;

rexpr: REALNUMBER
    | rexpr PLUS rexpr { $$ = $1 + $3; }
    | rexpr MINUS rexpr { $$ = $1 - $3; }
    | rexpr MULT rexpr { $$ = $1 * $3; }
    | rexpr DIV rexpr { $$ = $1 / $3; }
    | rexpr POW rexpr { $$ =  mypow($1, $3); }
    | LPAREN rexpr RPAREN { $$ = $2; } 
    | REALID {newsymbol = lookup_id($1); $$ = newsymbol.value.real;}
;
fexpr: LPAREN fexpr RPAREN { $$ = $2; } 
    | FLOAT
    | fexpr PLUS fexpr { $$ = $1 + $3; }
    | fexpr MINUS fexpr { $$ = $1 - $3; }
    | fexpr MULT fexpr { $$ = $1 * $3; }
    | fexpr DIV fexpr { $$ = $1 / $3; }
    | fexpr POW fexpr { $$ =  mypow($1, $3); }
    | fexpr PLUS rexpr { $$ = $1 + (float)$3; }
    | rexpr PLUS fexpr { $$ = (float)$1 + $3; }
    | fexpr MINUS rexpr { $$ = $1 - (float)$3; }
    | rexpr MINUS fexpr { $$ = (float)$1 - $3; }
    | fexpr MULT rexpr { $$ = $1 * (float)$3; }
    | rexpr MULT fexpr { $$ = (float)$1 * $3; }
    | fexpr DIV rexpr { $$ = $1 / (float)$3; }
    | rexpr DIV fexpr { $$ = (float)$1 / $3; }
    | fexpr POW rexpr { $$ =  mypow($1, (float)$3); }
    | rexpr POW fexpr { $$ =  mypow((float)$1, $3); }
    | FLOATID {newsymbol = lookup_id($1); $$ = newsymbol.value.floaty;}
;
string: string PLUS STRING //{ strcat($$, $3); }
    | STRING
    | STRINGID {newsymbol = lookup_id($1); $$ = newsymbol.value.str;}
;
id: REALID
    | FLOATID
    | STRINGID
    | BLANKID
;
//mexpr:
//;
//bexpr:
//;
%%
yyerror(char * str)
{
   fprintf(stdout, "syntax error on line %d.\n",line_num + 1);
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
struct symbol lookup_id(char *value)
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
          return symbolTable[i];
        }
      }  
   }	
}
//print out the value
void lookup_table(char *value)
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
            case 0 : printf("%d\n", symbolTable[i].value.real); break;
	    case 1 : printf("%f\n", symbolTable[i].value.floaty); break;
            case 2 : printf("%s\n", symbolTable[i].value.str); break;
            default: printf("How dare you!\n"); break;
          }
        }
      }  
   }
}void table_insert(char *target, struct symbol Symbol)
{
   int i = 0;
   int j = 0;
   //Linear serach your array
   for(i; i < 100; i++)
   {
      //if you come across that entry, overwrite
     if(symbolTable[i].id != NULL)
     {
       if (strcmp(symbolTable[i].id, target) == 0)
       {
          symbolTable[i] = Symbol;
          j = 1;
	  break;
       }
     }
   }
   //otherwise, create new entry in symbol table
   if (j != 1)
   {
      i = 0;
      //at the first null spot
      for(i; i < 100; i++)
      {
         if (symbolTable[i].id == NULL)
         {
            break;
         }
      }
      symbolTable[i] = Symbol;
   }   
}
