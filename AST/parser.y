%{
    #include "abstract_syntax_tree.h"
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(const char *);
    int yylex();
    extern int yylineno;
    expression_node* root = NULL; // Global variable to hold the root of the AST
%}

%union
{
    char* text;
    expression_node* exp_node;
}

%token <text> T_ID T_NUM

%type <exp_node> E T F ASSGN // Add ASSGN to the list of types

%start START

%%

START : ASSGN   {
                    printf("Valid syntax\n");
                    display_exp_tree(root); // Display the AST
                    printf("\n");
                    free_exp_tree(root); // Free memory allocated for the AST
                    YYACCEPT;
                }
      ;

ASSGN : T_ID '=' E    {
                            root = init_exp_node($1, NULL, $3); // Create the root of the AST
                            $$ = root;
                        }
      ;

E : E '+' T   {
                    $$ = init_exp_node("+", $1, $3); // Create a new node for addition
                }
    | E '-' T   {
                    $$ = init_exp_node("-", $1, $3); // Create a new node for subtraction
                }
    | T  {
            $$ = $1; // Pass the terminal node
        }
    ;

T : T '*' F   {
                    $$ = init_exp_node("*", $1, $3); // Create a new node for multiplication
                }
    | T '/' F   {
                    $$ = init_exp_node("/", $1, $3); // Create a new node for division
                }
    | F {
            $$ = $1; // Pass the terminal node
        }
    ;

F : '(' E ')' { $$ = $2; } // Pass the expression within parentheses
    | T_ID  {
                $$ = init_exp_node($1, NULL, NULL); // Create a terminal node for ID
            }
    | T_NUM  {
                $$ = init_exp_node($1, NULL, NULL); // Create a terminal node for NUM
            }
    ;

%%

void yyerror(const char* s)
{
    fprintf(stderr, "Error: %s at line %d\n", s, yylineno);
}

int main(int argc, char* argv[])
{
    yyparse();
    return 0;
}
