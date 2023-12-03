%option noyywrap
%{
#include "exp.tab.h"
int yyerror(char *sp);
%}
%%
[0-9]+ {yylval.vale=atoi(yytext); return NBI;}
[0-9]+\.[0-9]+ {yylval.valf=atof(yytext); return NBF;}
"+" {return ADD;}
"*" {return MULT;}
"-" {return SUB;}
"/" {return DIV;}
"(" {return PO;}
")" {return PV;}
[ \t] ;
"\n" {return NL;}
. {yyerror("Unkonwn Char !!!");}

%%
main(){
yyparse();
}
int yyerror(char *sp){
printf("%s", sp);
exit(1);
}
