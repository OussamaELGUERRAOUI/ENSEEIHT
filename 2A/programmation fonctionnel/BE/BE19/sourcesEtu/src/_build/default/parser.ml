type token =
  | INT of (int)
  | LPAR
  | RPAR
  | SEMICOL
  | COMA
  | DOT
  | DIM
  | BARRIER
  | AVAILABLETARGET
  | ROBOT
  | INITIALPOS
  | RED
  | GREEN
  | BLUE
  | YELLOW
  | BLACK
  | ANY
  | MOON
  | SATURN
  | STAR
  | SUN
  | EOF

open Parsing;;
let _ = parse_error;;
let yytransl_const = [|
  258 (* LPAR *);
  259 (* RPAR *);
  260 (* SEMICOL *);
  261 (* COMA *);
  262 (* DOT *);
  263 (* DIM *);
  264 (* BARRIER *);
  265 (* AVAILABLETARGET *);
  266 (* ROBOT *);
  267 (* INITIALPOS *);
  268 (* RED *);
  269 (* GREEN *);
  270 (* BLUE *);
  271 (* YELLOW *);
  272 (* BLACK *);
  273 (* ANY *);
  274 (* MOON *);
  275 (* SATURN *);
  276 (* STAR *);
  277 (* SUN *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  257 (* INT *);
    0|]

let yylhs = "\255\255\
\001\000\004\000\005\000\006\000\006\000\007\000\007\000\007\000\
\007\000\007\000\008\000\008\000\008\000\008\000\009\000\010\000\
\010\000\002\000\011\000\011\000\011\000\011\000\011\000\012\000\
\012\000\013\000\013\000\014\000\015\000\015\000\003\000\000\000"

let yylen = "\002\000\
\003\000\008\000\011\000\000\000\002\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\001\000\001\000\011\000\000\000\
\002\000\003\000\001\000\001\000\001\000\001\000\001\000\001\000\
\003\000\000\000\005\000\009\000\000\000\002\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\032\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\001\000\
\000\000\000\000\031\000\000\000\005\000\000\000\000\000\018\000\
\000\000\019\000\020\000\021\000\022\000\023\000\000\000\000\000\
\000\000\030\000\000\000\000\000\017\000\000\000\000\000\000\000\
\000\000\000\000\006\000\007\000\008\000\009\000\010\000\000\000\
\000\000\025\000\027\000\000\000\000\000\000\000\000\000\000\000\
\000\000\011\000\012\000\013\000\014\000\000\000\002\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\028\000\000\000\000\000\003\000\000\000\015\000"

let yydgoto = "\002\000\
\004\000\005\000\009\000\006\000\012\000\013\000\048\000\062\000\
\023\000\024\000\031\000\032\000\010\000\018\000\019\000"

let yysindex = "\255\255\
\251\254\000\000\007\255\000\000\010\255\013\255\021\255\022\255\
\023\000\014\255\024\255\013\255\018\255\023\255\255\254\000\000\
\026\255\014\255\000\000\029\255\000\000\030\255\018\255\000\000\
\025\255\000\000\000\000\000\000\000\000\000\000\031\255\033\255\
\255\254\000\000\028\255\249\254\000\000\036\255\255\254\032\255\
\034\255\039\255\000\000\000\000\000\000\000\000\000\000\037\255\
\038\255\000\000\000\000\042\255\040\255\254\254\041\255\043\255\
\045\255\000\000\000\000\000\000\000\000\044\255\000\000\049\255\
\046\255\051\255\050\255\053\255\052\255\054\255\055\255\058\255\
\000\000\056\255\060\255\000\000\059\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\004\000\001\000\000\000\000\000\
\000\000\034\000\000\000\001\000\003\000\000\000\000\000\000\000\
\000\000\034\000\000\000\000\000\000\000\000\000\003\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\061\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\032\000\000\000\000\000\
\000\000\033\000\022\000\027\000\000\000\000\000\043\000"

let yytablesize = 271
let yytable = "\001\000\
\004\000\003\000\016\000\026\000\043\000\044\000\045\000\046\000\
\007\000\047\000\026\000\027\000\028\000\029\000\030\000\058\000\
\059\000\060\000\061\000\008\000\011\000\014\000\016\000\015\000\
\017\000\020\000\022\000\033\000\025\000\035\000\038\000\036\000\
\042\000\029\000\039\000\040\000\049\000\051\000\052\000\053\000\
\055\000\054\000\056\000\021\000\057\000\065\000\063\000\064\000\
\066\000\067\000\068\000\069\000\070\000\071\000\041\000\037\000\
\072\000\074\000\075\000\073\000\034\000\076\000\077\000\024\000\
\078\000\050\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\004\000\004\000\004\000\016\000\016\000\026\000"

let yycheck = "\001\000\
\000\000\007\001\000\000\000\000\012\001\013\001\014\001\015\001\
\002\001\017\001\012\001\013\001\014\001\015\001\016\001\018\001\
\019\001\020\001\021\001\010\001\008\001\001\001\000\000\002\001\
\011\001\002\001\009\001\002\001\006\001\001\001\006\001\002\001\
\005\001\000\000\004\001\003\001\001\001\006\001\005\001\001\001\
\003\001\005\001\001\001\012\000\005\001\001\001\006\001\005\001\
\005\001\001\001\005\001\001\001\003\001\001\001\033\000\023\000\
\005\001\003\001\001\001\006\001\018\000\006\001\003\001\003\001\
\006\001\039\000\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\009\001\010\001\011\001\010\001\011\001\011\001"

let yynames_const = "\
  LPAR\000\
  RPAR\000\
  SEMICOL\000\
  COMA\000\
  DOT\000\
  DIM\000\
  BARRIER\000\
  AVAILABLETARGET\000\
  ROBOT\000\
  INITIALPOS\000\
  RED\000\
  GREEN\000\
  BLUE\000\
  YELLOW\000\
  BLACK\000\
  ANY\000\
  MOON\000\
  SATURN\000\
  STAR\000\
  SUN\000\
  EOF\000\
  "

let yynames_block = "\
  INT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'board) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'initial_pos) in
    Obj.repr(
# 14 "parser.mly"
                        ( _1, _2 )
# 221 "parser.ml"
               : Be.Plateau.t * (Be.Plateau.robot * (int * int)) list))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 5 : int) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : int) in
    Obj.repr(
# 18 "parser.mly"
    ( if _3 <> 1 then raise (Invalid_argument "dimension should be given as \"dim(1..<n>).\"");
      if _6 > 16 then raise (Invalid_argument "dimension should be at most 16");
      _6 )
# 231 "parser.ml"
               : 'dim))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 8 : int) in
    let _5 = (Parsing.peek_val __caml_parser_env 6 : int) in
    let _7 = (Parsing.peek_val __caml_parser_env 4 : int) in
    let _9 = (Parsing.peek_val __caml_parser_env 2 : int) in
    Obj.repr(
# 24 "parser.mly"
    ( let x, y, dx, dy = _3, _5, _7, _9 in
      if (dx <> 0 && dy <> 0) || (dx = 0 && dy = 0) then raise (Invalid_argument "barriers should be either horizontal or vertical");
      if dx < 0 then x - 1, y - 1, Be.Wall.Wleft
      else if dx > 0 then x, y - 1, Be.Wall.Wleft
      else if dy < 0 then x - 1, y - 1, Be.Wall.Wtop
      else (* dy > 0 *) x - 1, y, Be.Wall.Wtop
    )
# 247 "parser.ml"
               : 'barrier))
; (fun __caml_parser_env ->
    Obj.repr(
# 33 "parser.mly"
              ( [] )
# 253 "parser.ml"
               : 'barriers))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'barrier) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'barriers) in
    Obj.repr(
# 34 "parser.mly"
                   ( _1 :: _2 )
# 261 "parser.ml"
               : 'barriers))
; (fun __caml_parser_env ->
    Obj.repr(
# 37 "parser.mly"
      ( Be.Wall.Tred )
# 267 "parser.ml"
               : 'target_color))
; (fun __caml_parser_env ->
    Obj.repr(
# 38 "parser.mly"
        ( Be.Wall.Tgreen )
# 273 "parser.ml"
               : 'target_color))
; (fun __caml_parser_env ->
    Obj.repr(
# 39 "parser.mly"
       ( Be.Wall.Tblue )
# 279 "parser.ml"
               : 'target_color))
; (fun __caml_parser_env ->
    Obj.repr(
# 40 "parser.mly"
         ( Be.Wall.Tyellow )
# 285 "parser.ml"
               : 'target_color))
; (fun __caml_parser_env ->
    Obj.repr(
# 41 "parser.mly"
      ( Be.Wall.Tany )
# 291 "parser.ml"
               : 'target_color))
; (fun __caml_parser_env ->
    Obj.repr(
# 44 "parser.mly"
       ( Be.Wall.Tmoon )
# 297 "parser.ml"
               : 'target_type))
; (fun __caml_parser_env ->
    Obj.repr(
# 45 "parser.mly"
         ( Be.Wall.Tsaturn )
# 303 "parser.ml"
               : 'target_type))
; (fun __caml_parser_env ->
    Obj.repr(
# 46 "parser.mly"
       ( Be.Wall.Tstar )
# 309 "parser.ml"
               : 'target_type))
; (fun __caml_parser_env ->
    Obj.repr(
# 47 "parser.mly"
      ( Be.Wall.Tsun )
# 315 "parser.ml"
               : 'target_type))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 8 : 'target_color) in
    let _5 = (Parsing.peek_val __caml_parser_env 6 : 'target_type) in
    let _7 = (Parsing.peek_val __caml_parser_env 4 : int) in
    let _9 = (Parsing.peek_val __caml_parser_env 2 : int) in
    Obj.repr(
# 51 "parser.mly"
    ( _7 - 1, _9 - 1, _3, _5 )
# 325 "parser.ml"
               : 'target))
; (fun __caml_parser_env ->
    Obj.repr(
# 54 "parser.mly"
              ( [] )
# 331 "parser.ml"
               : 'targets))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'target) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'targets) in
    Obj.repr(
# 55 "parser.mly"
                 ( _1 :: _2 )
# 339 "parser.ml"
               : 'targets))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'dim) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'barriers) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'targets) in
    Obj.repr(
# 58 "parser.mly"
                       ( Be.Plateau.make _1 _2 _3 )
# 348 "parser.ml"
               : 'board))
; (fun __caml_parser_env ->
    Obj.repr(
# 61 "parser.mly"
      ( Be.Plateau.Rrouge )
# 354 "parser.ml"
               : 'robot_color))
; (fun __caml_parser_env ->
    Obj.repr(
# 62 "parser.mly"
        ( Be.Plateau.Rvert )
# 360 "parser.ml"
               : 'robot_color))
; (fun __caml_parser_env ->
    Obj.repr(
# 63 "parser.mly"
       ( Be.Plateau.Rbleu )
# 366 "parser.ml"
               : 'robot_color))
; (fun __caml_parser_env ->
    Obj.repr(
# 64 "parser.mly"
         ( Be.Plateau.Rjaune )
# 372 "parser.ml"
               : 'robot_color))
; (fun __caml_parser_env ->
    Obj.repr(
# 65 "parser.mly"
        ( Be.Plateau.Rnoir )
# 378 "parser.ml"
               : 'robot_color))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'robot_color) in
    Obj.repr(
# 68 "parser.mly"
              ( )
# 385 "parser.ml"
               : 'robot_colors))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'robot_color) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'robot_colors) in
    Obj.repr(
# 69 "parser.mly"
                                   ( )
# 393 "parser.ml"
               : 'robot_colors))
; (fun __caml_parser_env ->
    Obj.repr(
# 72 "parser.mly"
              ( )
# 399 "parser.ml"
               : 'robots))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'robot_colors) in
    Obj.repr(
# 73 "parser.mly"
                                   ( )
# 406 "parser.ml"
               : 'robots))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 6 : 'robot_color) in
    let _5 = (Parsing.peek_val __caml_parser_env 4 : int) in
    let _7 = (Parsing.peek_val __caml_parser_env 2 : int) in
    Obj.repr(
# 77 "parser.mly"
    ( (_3, (_5 - 1, _7 - 1)) )
# 415 "parser.ml"
               : 'pos))
; (fun __caml_parser_env ->
    Obj.repr(
# 80 "parser.mly"
              ( [] )
# 421 "parser.ml"
               : 'poss))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'pos) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'poss) in
    Obj.repr(
# 81 "parser.mly"
           ( _1 :: _2 )
# 429 "parser.ml"
               : 'poss))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'robots) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'poss) in
    Obj.repr(
# 84 "parser.mly"
              ( _2 )
# 437 "parser.ml"
               : 'initial_pos))
(* Entry file *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let file (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Be.Plateau.t * (Be.Plateau.robot * (int * int)) list)
