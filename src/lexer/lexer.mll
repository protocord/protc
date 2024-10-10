{
  open Parser
}

rule tokenize = parse

  (* Common keywords *)

  | "obj" { OBJ }
  | "ref" { REF }
  | "def" { DEF }

  (* Logic keywords *)

  | "or" { OR }
  | "and" { AND }
  | "is" { IS }

  (* Special symbols *)

  | "{" { LBR }
  | "}" { RBR }
  | ":" { COL }
  | "," { COM }
  | "(" { LPA }
  | ")" { RPA }
  | "=" { EQ }
  | eof { EOF }

  (* Identifier *)

  | ['a'-'z' 'A'-'Z']+ as id { ID id }
 
  (* Indent *)

  | [' ' '\t' '\r' '\n']  { tokenize lexbuf }

  (* Unknown token *)
  
  | _ { raise (Failure "Unknown token") }
