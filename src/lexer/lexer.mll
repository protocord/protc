{
  open Parser
}

rule tokenize = parse
  | [' ' '\t' '\r' '\n']  { tokenize lexbuf }
  | ['a'-'z' 'A'-'Z']+ as id { ID id }
  | eof { EOF }
  | _ { raise (Failure "Unknown token") }
