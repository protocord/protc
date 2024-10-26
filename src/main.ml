let () =
  let lexbuf = Lexing.from_channel stdin in
  try
    let program = Parser.root Lexer.tokenize lexbuf in

    List.iter
      (function
        | Ast.DeclarationDefinition (Ast.Definition (Ast.Identifier name, _)) ->
            Printf.printf "Parsed definition: %s\n" name
        | Ast.DeclarationObject (Ast.Object (Ast.Type name, traits, refs)) ->
            Printf.printf "Parsed object: %s with %d traits and %d references\n"
              name (List.length traits) (List.length refs))
      program
  with
  | Failure msg -> Printf.eprintf "Lexer error: %s\n" msg
  | Parser.Error ->
      let pos = lexbuf.Lexing.lex_curr_p in
      Printf.eprintf "Syntax error at line %d, position %d\n"
        pos.Lexing.pos_lnum
        (pos.Lexing.pos_cnum - pos.Lexing.pos_bol)
