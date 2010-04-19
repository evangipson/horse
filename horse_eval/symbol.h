#include <stdio.h>

typedef union 
{
  int real;
  float floaty;
  char *str;
}MyUnion;
struct symbol
{
  char *id;
  int type;
  MyUnion value;
} ;

struct symbol symbolTable[100];
struct symbol newsymbol;
