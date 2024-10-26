{
  open Parser
}

(* Constants *)

let upper = ['A'-'Z']
let lower = ['a'-'z']
let alpha = ['A'-'Z' 'a'-'z']

(* Parsing *)

rule tokenize = parse

  (* Common keywords *)

  | "obj" { OBJ }
  | "ref" { REF }
  | "def" { DEF }

  (* Logic keywords *)

  | "not" { NOT }
  | "and" { AND }
  | "or" { OR }
  | "is" { IS }

  (* Special symbols *)

  | "." { DOT }
  | "{" { LBR }
  | "}" { RBR }
  | ":" { COL }
  | "," { COM }
  | "(" { LPA }
  | ")" { RPA }
  | "=" { EQL }
  | eof { EOF }

  (* Identifier *)

  | upper alpha* as uid { UID uid }
  | lower alpha* as lid { LID lid }
 
  (* Indent *)

  | [' ' '\t' '\r' '\n']  { tokenize lexbuf }

  (* Unknown token *)
  
  | _ { raise (Failure "Unknown token") }
