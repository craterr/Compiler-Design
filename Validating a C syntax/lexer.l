

%{
#include<stdio.h>
#include "y.tab.h"
int yywrap();
int yylineno;
%}


letter [a-zA-Z]
digit [0-9]
id {letter}(_|{letter}|{digit})*
opfrac (\.{digit})?
opexponent ([Ee][+-]?{digit}+)?
number {opsign}{digit}+{opfrac}{opexponent}
strlit \".*\"
opsign [+-]?
start	\/\*
end	\*\/	



%%
\/\/(.*) ;
\/\*(.*\n)*.*\*\/  {};

int	return INT;
float	return FLOAT;
char	return CHAR;
bool	return BOOL;
if	return IF;
else	return ELSE;
for	return FOR;
while	return WHILE;
do	return DO;
break	return BREAK;
double	return DOUBLE;
static 	return STATIC;
main	return MAIN;
#include return INCLUDE;
"<"(.+)".h>" return HEADER;
{id}	return ID;
{number}	return VNUM;
{strlit}	return STRLIT;

"<"	return LT;
">"	return GT;
"++"	return INC;
"--"	return DEC;
"||"	return OR;
"&&"	return AND;
"!"	return LNOT;
"("	return SCOMB;
")"	return ECOMB;
">="	return GTE;	
"<="	return LTE;
"=="	return EQ;
"!="	return NE;
"["	return SSQB;
"]"	return ESQB;
"{"	return SCURB;
"}"	return ECURB;
\r	;
[' '|'\t']	;
\n	++yylineno;
.	return *yytext;

%%
int yywrap()
{

}




