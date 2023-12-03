%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
int yyerror(const char *s);
int error = 0;
%}
%union{
int vale;
float valf;
}
%token<vale> NBI
%token<valf> NBF
%token NL 
%token ADD
%token MULT
%token DIV
%token SUB
%token PO
%token PV
%left ADD
%left SUB
%left MULT DIV 
%type<vale> expression
%type<valf> expressionf
%start calcul
%%
calcul : 
       |calcul exp
       ;
exp : NL
    |expression NL {if (error == 0) {printf("Result %i \n ",$1);}}
    |expressionf NL {if (error == 0) {printf("Result %i \n ",$1);}}
    ;
expression : NBI {$$=$1;}
           | expression ADD expression {$$=$1+$3;}
           | expression MULT expression {$$=$1*$3;}
           | expression SUB expression {$$=$1-$3;}
           | expression DIV expression {if ( $3 == 0) { printf("there is an error\n"); error = 1;} else {$$=$1/$3;}}
           | PO expression PV {$$=$2;}
           ;
expressionf : NBF {$$=$1;}
            | expressionf ADD expressionf {$$=$1+$3;}
            | expression ADD expressionf {$$=$1+$3;}
            | expressionf ADD expression {$$=$1+$3;}
            | expressionf MULT expressionf {$$=$1*$3;}
            | expression MULT expressionf {$$=$1*$3;}
            | expressionf MULT expression {$$=$1*$3;}
            | expressionf SUB expressionf {$$=$1-$3;}
            | expression SUB expressionf {$$=$1-$3;}
            | expressionf SUB expression {$$=$1-$3;}
            | expressionf DIV expressionf {if ($3 == 0) {printf("there is an error\n"); error = 1;} else {$$=$1/$3;}}
            | expression DIV expressionf {if ($3 == 0) {printf("there is an error\n"); error = 1;} else {$$=$1/$3;}}
            | expressionf DIV expression {if ($3 == 0) {printf("there is an error\n"); error = 1;} else {$$=$1/$3;}}
            ; 
%%

