%{
    open Ast
%}

(* Common keywords *)

%token OBJ
%token REF
%token DEF

(* Logic keywords *)

%token OR
%token AND
%token IS

(* Special symbols *)

%token LBR
%token RBR
%token COL
%token COM
%token LPA
%token RPA
%token EQ
%token EOF

(* Identifier *)

%token <string> ID

(* Root *)

%start root
%type <Ast.root> root

%%

root:
  | expr_list EOF { $1 }

expr_list:
  | expr { [$1] }
  | expr expr_list { $1 :: $2 }

expr:
  | ID { Var $1 }
