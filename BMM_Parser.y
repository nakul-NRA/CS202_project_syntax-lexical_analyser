%{
#include <stdio.h>
#include <math.h>
int yylex();
void yyerror(char* s);
%}
%token INT_ID SINGLE_PRE_ID DOUBLE_PRE_ID STRING_ID CHAR 
%token INTEGER FLOAT STRING NEWLINE EXP LPAREN RPAREN SEMICOLON COMMA
%token DATA 
%token IF THEN  DEF FN DIM END FOR TO STEP NEXT GOSUB GOTO RETURN REM LET INPUT PRINT 
%token STOP 
%left EXP
%left MULTIPLY DIVIDE 
%left PLUS MINUS
%left EQ NE LT GT LE GE
%left NOT
%left AND
%left OR 
%left XOR
%%
program: statements end_statement;
statements: statements statement
    | statement
    ;
statement:
    INTEGER  statement_type  NEWLINE
    ;
statement_type:
    DATA_stmt
    | DEF_stmt
    | DIM_stmt
    | FOR_stmt
    | GOSUB_stmt
    | GOTO_stmt
    | IF_stmt
    | INPUT_stmt
    | LET_stmt
    | PRINT_stmt
    | RETURN
    | STOP
    | REM_stmt
    ;
end_statement:
    INTEGER  END  NEWLINE
    ;
DATA_stmt:
    DATA  data_list
    ;
DEF_stmt:
    DEF FN LPAREN variable RPAREN  EQ  expression
    | DEF FN EQ  expression
    ;
variable:
    INT_ID
    | SINGLE_PRE_ID
    | DOUBLE_PRE_ID
    | STRING_ID
    | CHAR
    ;
expression:
    relational_expression
    | NOT  expression
    | expression  AND expression
    | expression  OR expression
    | expression  XOR expression
    ;
relational_expression:
    arithmetic_expression
    | relational_expression EQ relational_expression
    | relational_expression NE relational_expression
    | relational_expression LT relational_expression
    | relational_expression GT relational_expression
    | relational_expression LE relational_expression
    | relational_expression GE relational_expression
    ;
arithmetic_expression:
    term
    | arithmetic_expression PLUS arithmetic_expression
    | arithmetic_expression MINUS arithmetic_expression
    | arithmetic_expression MULTIPLY arithmetic_expression
    | arithmetic_expression DIVIDE arithmetic_expression
    ;
term:
    MINUS term
    | term EXP term
    | factor
    ;
factor:
    LPAREN expression RPAREN
    | INT_ID
    | SINGLE_PRE_ID
    | DOUBLE_PRE_ID
    | INTEGER
    | CHAR
    | FLOAT
    | array_access
    ;
array_access:
    CHAR LPAREN array_var RPAREN
    | CHAR LPAREN array_var COMMA array_var RPAREN
    ;
array_var:
    INT_ID
    | INTEGER
    | SINGLE_PRE_ID
    | DOUBLE_PRE_ID
    | CHAR
    ;
data_list:
    | data COMMA  data_list
    | data
    ;
data:
    INTEGER
    | FLOAT
    | STRING
    ;
DIM_stmt:
    DIM array_access_list
    ;
array_access_list:
    array_access_list COMMA array_access
    | array_access
    ;
FOR_stmt:
    FOR for_variable EQ expression TO expression STEP arithmetic_expression NEWLINE statements INTEGER NEXT for_variable
    | FOR for_variable EQ expression TO expression NEWLINE statements INTEGER NEXT for_variable
    ;
for_variable:
    INT_ID
    | SINGLE_PRE_ID
    | DOUBLE_PRE_ID
    | CHAR
    ;
GOSUB_stmt:
    GOSUB INTEGER
    ;
GOTO_stmt:
    GOTO INTEGER
    ;
IF_stmt:
    IF if_condition THEN INTEGER
    ;
if_condition:
    expression
    | string_expression EQ string_expression
    | string_expression NE string_expression
    ;
string_expression:
    STRING
    | STRING_ID
    ;
INPUT_stmt:
    INPUT input_variable_list
    ;
input_variable_list:
    input_variable_list COMMA input_variable
    | input_variable
    ;
input_variable:
    INT_ID
    | SINGLE_PRE_ID
    | DOUBLE_PRE_ID
    | STRING_ID
    | CHAR
    | array_access
    ;
LET_stmt:
    LET num_var EQ expression
    | LET STRING_ID EQ string_expression
    ;
num_var:
    INT_ID
    | SINGLE_PRE_ID
    | DOUBLE_PRE_ID
    | array_access
    | CHAR
    ;
PRINT_stmt:
    PRINT
    | PRINT print_list
    ;
print_list:
    print_list delimiter print_item
    | print_item
    ;
delimiter:
    COMMA
    | SEMICOLON
    ;
print_item:
    expression
    | string_expression
    ;
REM_stmt:
    REM REM_expression
    ;
REM_expression:
    CHAR
    | CHAR REM_expression

%%
void yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
int main() {
    yyparse();
    return 0;
}
