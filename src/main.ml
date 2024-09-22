let () =
  let lexbuf = Lexing.from_channel stdin in

  try
    let program = Parser.program Lexer.tokenize lexbuf in

    List.iter
      (function Ast.Var id -> Printf.printf "Parsed variable: %s\n" id)
      program
  with Failure msg -> Printf.eprintf "Lexer error: %s\n" msg
