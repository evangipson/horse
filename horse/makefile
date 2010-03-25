run : ./syntax
	./syntax

syntax : y.tab.c lex.yy.c main.c
	gcc *.c -o syntax

y.tab.c : horse.y
	yacc -d horse.y

lex.yy.c : horse.l
	lex horse.l
