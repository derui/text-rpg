type t = Wait of int | Active of int

(* ターンが回ってきたと判定される閾値 *)
let turn_threshold = 1000

let create () = Wait 0

let next_tick t s =
  match t with
  | Wait t ->
    let next = t + (Natural.to_int s) in
    if turn_threshold <= next then
      Active (next - turn_threshold)
    else
      Wait next
  | Active t -> Wait (t - turn_threshold)

let is_active = function
  | Wait _ -> false
  | Active _ -> true

let is_wait = function
  | Wait _ -> true
  | Active _ -> false
