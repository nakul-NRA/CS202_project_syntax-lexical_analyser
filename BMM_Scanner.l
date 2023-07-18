%{
    #include <stdio.h>
    #include "y.tab.h"
    void yyerror(char *);
%}

%%
[A-Z][0-9]%?            { printf("INT_ID\n"); return INT_ID;}
[A-Z][0-9]?!            { printf("SINGLE_PRE_ID\n"); return SINGLE_PRE_ID;}
[A-Z][0-9]?#            { printf("DOUBLE_PRE_ID\n"); return DOUBLE_PRE_ID;}
[A-Z][0-9]?\$           { printf("STRING_ID\n"); return STRING_ID;}
[A-Z]                   { printf("CHAR\n"); return CHAR;}
[0-9]+                  { printf("INTEGER\n"); yylval = atoi(yytext); return INTEGER;}
[0-9]+\.[0-9]+          { printf("FLOAT\n"); return FLOAT;}
\".*?\"                 { printf("STRING\n"); return STRING;} 
[\n]+                   { printf("NEWLINE\n"); return NEWLINE;}
"^"                     { printf("EXP\n");return EXP; }
"("                     { printf("LPAREN\n");return LPAREN; }
")"                     { printf("RPAREN\n");return RPAREN; }
";"                     { printf("SEMICOLON\n");return SEMICOLON; }
","                     { printf("COMMA\n");return COMMA; }
"+"                     { printf("PLUS\n");return PLUS; }
"-"                     { printf("MINUS\n");return MINUS; }
"*"                     { printf("MULTIPLY\n");return MULTIPLY; }
"/"                     { printf("DIVIDE\n");return DIVIDE; }
"<"                     { printf("LT\n");return LT; }
"<="                    { printf("LE\n");return LE; }
">"                     { printf("GT\n");return GT; }
">="                    { printf("GE\n"); return GE; }
"="                     { printf("EQUAL\n"); return EQ; }
"<>"                    { printf("UNEQUAL\n"); return NE; }
NOT                     { printf("NOT\n"); return NOT;}
AND                     { printf("AND\n"); return AND;}
OR                      { printf("OR\n"); return OR;}
XOR                     { printf("XOR\n"); return XOR;}
DATA                    { printf("DATA\n"); return DATA;}
[ ]+                    { printf("SPACE\n");}
DEF                     { printf("DEF\n"); return DEF;}
FN[A-Z]                 { printf("FN\n"); return FN;}      
DIM                     { printf("DIM\n"); return DIM;}  
END                     { printf("END\n"); return END;}
FOR                     { printf("FOR\n"); return FOR;}
TO                      { printf("TO\n"); return TO;}
STEP                    { printf("STEP\n"); return STEP;}
NEXT                    { printf("NEXT\n"); return NEXT;}
GOSUB                   { printf("GOSUB\n"); return GOSUB;}
RETURN                  { printf("RETURN\n"); return RETURN;}
GOTO                    { printf("GOTO\n"); return GOTO;}
IF                      { printf("IF\n"); return IF;}
THEN                    { printf("THEN\n"); return THEN;}
LET                     { printf("LET\n"); return LET;}
INPUT                   { printf("INPUT\n"); return INPUT;}
PRINT                   { printf("PRINT\n"); return PRINT;}
REM                     { printf("REM\n"); return REM;}
STOP                    { printf("STOP\n"); return STOP;}
\t                      { yyerror("TAB DETECTED"); }
%%

int yywrap() {
    return 1;
}
