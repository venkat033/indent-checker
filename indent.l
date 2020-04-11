%{
#include "y.tab.h"
#include<stdio.h>
#include<string.h>
int l=1;
%}


alpha [a-zA-Z]
num [0-9]
%%
[\n] ;
[\t]+ { 
	yylval=strlen(yytext)*4;
	return TAB;
}
"if" return IF;
"else if" return ELSEIF;
"else" return ELSE;
"start" return START;
"end" return END;
"for" return FOR;
"printf" return PRINT;
{alpha}+ return ID;
{num}+ return NUM;
. return yytext[0];
"in range" return RANGE;

%%


