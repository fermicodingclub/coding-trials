exception BadState

(* There are two players, designated as 'X' or 'O'. *)

type player = O | X

type dir_info = (int * player) option

type cell_state = dir_info * dir_info * dir_info * dir_info

type board = cell_state array

(* This holds the computed game state. *)

type game_state = {
    mutable winner : player option;
    mutable any_empty : bool;
    mutable x_moves : int;
    mutable o_moves : int
  }

let char_to_player = function
  | 'X' -> Some X
  | 'O' -> Some O
  | '.' -> None
  | _ -> raise (Invalid_argument "bad input character")

let left (v, _, _, _) = v
and up_left (_, v, _, _) = v
and up (_, _, v, _) = v
and up_right (_, _, _, v) = v

let merge nbor tgt =
  match nbor, tgt with
  | _, None ->                                  None
  | Some (va, a), Some (_, b) when a = b ->     Some (va + 1, a)
  | _, (Some (_, _) as b) ->                    b

let update_game_state m state cell =
  let update = function
    | None -> state.any_empty <- true
    | Some (v, p) -> if v = m then
                       begin
                         if state.winner = None then
                           state.winner <- Some p
                         else if state.winner <> Some p then
                           raise BadState
                       end
                     else if v >= m * 2 then
                       raise BadState
  in
  begin
    update @@ left cell;
    update @@ up_left cell;
    update @@ up cell;
    update @@ up_right cell
  end

let analyze_board () =
  let result = { winner = None; any_empty = false; x_moves = 0; o_moves = 0 }
  and n, m = Scanf.scanf " %d %d" (fun n m -> n, m)
  in
  if 1 <= m && m <= n && n < 1000 then
    let board = Array.make (n * n) (None, None, None, None)
    in
    let get_cell r c = board.(r * n + c)
    in

    (* Builds a 4-tuple where each element is the result of merging
       the current value with the left, upper left, upper, and upper
       right neighbor cells, respectively. *)

    let bld_cell r c p =
      ((if c > 0 then
          merge (get_cell r (c - 1) |> left) p else p),
       (if c > 0 && r > 0 then
          merge (get_cell (r - 1) (c - 1) |> up_left) p else p),
       (if r > 0 then
          merge (get_cell (r - 1) c |> up) p else p),
       (if c < (n - 1) && r > 0 then
          merge (get_cell (r - 1) (c + 1) |> up_right) p else p))
    in
    try

      (* Loop through every position. *)

      for row = 0 to (n - 1) do
        for col = 0 to (n - 1) do

          (* Read in a character (and translate it to a cell value.)
             If it's None, we don't do anything since the array is
             already initialized with the cell info as all None. *)

          match Scanf.scanf " %c" char_to_player with
          | Some p ->
             let new_cell = bld_cell row col (Some (1, p)) in
             begin
               if p = X then
                 result.x_moves <- result.x_moves + 1
               else
                 result.o_moves <- result.o_moves + 1;
               update_game_state m result new_cell;
               board.(row * n + col) <- new_cell
             end
          | None -> ()
        done
      done;

      (* Compare the number of moves each player made. If the
         difference is greater than 1, we have an invalid state. *)

      if abs (result.x_moves - result.o_moves) > 1 then
        raise BadState;

      (* Use the computed game state to determine the proper
         output. *)

      match result with
      | { winner = Some X } ->                  print_string "X WINS"
      | { winner = Some O } ->                  print_string "O WINS"
      | { winner = None; any_empty = true } ->  print_string "IN PROGRESS"
      | { winner = None; any_empty = false } -> print_string "DRAW"
    with BadState ->
      print_string "ERROR"
  else
    raise (Invalid_argument "bad dimension sizes")
