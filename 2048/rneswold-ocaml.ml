type cell = Empty
          | Full of int

type board = cell array

type move = Left | Up | Right | Down

(* Read the board and movement from standard input. *)

let load_board () =

  (* Convert an integer into a cell value. *)

  let int_to_cell = function
    | 0 -> Empty
    | n -> if n > 0 && n < 2048 && ((n - 1) land n) = 0 then
             Full n
           else
             raise (Invalid_argument "bad value for cell")

  (* Convert an integer into a movement value. *)

  and int_to_move = function
    | 0 -> Left
    | 1 -> Up
    | 2 -> Right
    | 3 -> Down
    | _ -> raise (Invalid_argument "bad value for move")
  in
  let arr = Array.init 16 (fun _ -> Scanf.scanf " %d" int_to_cell) in
  (arr, Scanf.scanf " %d" int_to_move)

(* Performs the shift of board pieces. The parameter 'set' is a
   function that takes an index and a 'cell' value. The value is
   placed in the output board at the i-th position of the current
   row. The 'get' parameter is a function that takes an integer
   argument and returns the i-th cell of the current row of the input
   board.

   This algorithm only works for a shift left operation. The 'get'
   parameter is a function customized for each direction so the order
   of the cells appears to be a left shift movement. *)

let shift set get =

  (* This function returns the next, non-Empty cell value from the
     array. Once all Filled cells are returned, this only returns
     Empty. *)

  let next =
    let idx = ref 0 in
    let rec find () =
      if !idx < 4 then
        match get !idx with
        | Empty ->         (idx := !idx + 1; find ())
        | Full _ as v ->   (idx := !idx + 1; v)
      else
        Empty
    in
    find
  in

  (* This function steps through each cell returned by 'next ()' and
     determines what needs to be set in the outgoing array. *)

  let rec step idx = function
    | Empty -> ()
    | Full a' as a ->
       begin
         match next () with
         | Empty ->
            set idx a
         | Full b' when a' = b' ->
            begin
              set idx @@ Full (a' + b');
              step (idx + 1) @@ next ()
            end
         | Full _ as b ->
            begin
              set idx a;
              step (idx + 1) b
            end
       end
  in
  step 0 @@ next ()

(* This function takes a movement direction and returns a pair of
   functions that can get and set, respectively, locations of a
   16-element array. *)

let mk_accessors =
  let mk_funcs base_off next_el next_row =
    (fun brd row idx -> brd.(base_off + next_row * row + next_el * idx)),
    (fun brd row idx v -> brd.(base_off + next_row * row + next_el * idx) <- v)
  in
  function
  | Left ->   mk_funcs 0 1 4
  | Up ->     mk_funcs 0 4 1
  | Right ->  mk_funcs 3 (-1) 4
  | Down ->   mk_funcs 12 (-4) 1

let perform_move brd mv =
  let g, s = mk_accessors mv
  and result = Array.make 16 Empty in
  begin
    for ii = 0 to 3 do
      shift (s result ii) (g brd ii)
    done;
    result
  end

let cell_to_int = function
  | Empty -> 0
  | Full v -> v

let print_brd brd =
  for ii = 0 to 3 do
    for jj = 0 to 3 do
      Printf.printf " %4d" @@ cell_to_int brd.(jj + ii * 4)
    done;
    print_newline ()
  done
