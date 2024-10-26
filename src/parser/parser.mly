%{
    open Ast

    (* Complex nodes *)

    let termTraitIdentifier tok_id tok_type =
      TermTrait (TraitIdentifier (tok_id, tok_type))

    let termReferenceIdentifier tok_id tok term_tok_list =
      TermReference (ReferenceIdentifier (tok_id, tok, term_tok_list))

%}

(* Common keywords *)

%token OBJ
%token REF
%token DEF

(* Logic keywords *)

%left AND
%left OR

%token NOT
%token AND
%token OR
%token IS

(* Special symbols *)

%token DOT
%token LBR
%token RBR
%token COL
%token COM
%token LPA
%token RPA
%token EQL
%token EOF

(* Identifier *)

%token <string> UID
%token <string> LID

(* Root *)

%start root
%type <Ast.root> root

%%

root:
  | decl_list EOF { $1 }

decl_list:
  | decl { [$1] }
  | decl decl_list { $1 :: $2 }

decl:
  | obj { DeclarationObject $1 }
  | def { DeclarationDefinition $1 }

(* Identifier *)

tok:
  | tok_type { TokenType $1 }
  | tok_id { TokenIdentifier $1 }

tok_id:
  | LID { Identifier $1 }

tok_type:
  | UID { Type $1 }

(* Definition *)

def:
  | DEF tok_id EQL expr { Definition ($2, $4) }

expr:
  | expr AND expr { Expression (And, $3) }
  | expr OR expr { Expression (Or, $3) }
  | LPA expr RPA { $2 }
  | term { Term $1 }

term:
  | tok_id IS tok_type { termTraitIdentifier $1 $3 }
  | tok DOT tok_id LPA term_tok_list RPA { termReferenceIdentifier $3 $1 $5 }

term_tok_list:
  | tok { [$1] }
  | tok COM term_tok_list { $1 :: $3 }

(* Object *)

obj:
  | OBJ tok_type { Object ($2, [], []) }
  | OBJ tok_type LBR ref_list RBR { Object ($2, [], $4) }
  | OBJ tok_type COL trait_list { Object ($2, $4, []) }
  | OBJ tok_type COL trait_list LBR ref_list RBR { Object ($2, $4, $6) }

(* Reference *)

ref_list:
  | ref { [$1] }
  | ref ref_list { $1 :: $2 }

ref:
  | REF tok_id LPA ref_arg_list RPA { Reference ($2, $4) }

ref_arg_list:
  | tok_type { [$1] }
  | tok_type COM ref_arg_list { $1 :: $3 }

(* Trait *)

trait_list:
  | tok_type { [Trait $1] }
  | tok_type COM trait_list { Trait $1 :: $3 }
