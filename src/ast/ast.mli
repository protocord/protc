[@@@ocamlformat "disable"]

(* Identifier *)

type token_node =
  | TokenType of type_node
  | TokenIdentifier of id_node

and id_node = Identifier of string
and type_node = Type of string

(* Object *)

type obj_node = Object of type_node * trait_node list * ref_node list

and ref_node =
  | Reference of id_node * type_node list
  | ReferenceIdentifier of id_node * token_node * token_node list

and trait_node =
  | Trait of type_node
  | TraitIdentifier of id_node * type_node

(* Definition *)

type def_node = Definition of id_node * expr_node

and expr_node =
  | Expression of op_node * expr_node
  | Term of term_node

and term_node =
  | TermTrait of trait_node
  | TermReference of ref_node

and op_node = And | Or | Is

(* Root *)

type root = decl_node list

and decl_node =
  | DeclarationObject of obj_node
  | DeclarationDefinition of def_node
