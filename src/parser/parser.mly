%{
    open Ast
%}

%token <string> ID
%token EOF

%start program
%type <Ast.program> program

%%

program:
  | expr_list EOF { $1 }

expr_list:
  | expr { [$1] }
  | expr expr_list { $1 :: $2 }

expr:
  | ID { Var $1 }
