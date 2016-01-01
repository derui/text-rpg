open Core.Std

  (* Buff is an buff/debuff to actor. *)
type t = {
  element: Status_element.t;
  weight: Float.t;
  duration: Int.t;
}  [@@deriving sexp]

let make ~element ~weight ~duration = {
  element; weight; duration;
}

let pass_turn t ?f () =
  match f with
  | None -> {t with duration = t.duration - 1}
  | Some f -> {t with duration = t.duration - 1; weight = f t.weight}

let is_finished t = t.duration <= 0
