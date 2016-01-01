open Core.Std

(* Buff is an buff/debuff to actor. *)
type t [@@deriving sexp]

val make: element:Status_element.t -> weight: Float.t -> duration: Int.t -> t
(* [make ~element ~weight ~duration] gets a new buff with parameters *)

val pass_turn: t -> ?f:(Float.t -> Float.t) -> unit -> t
(* [pass_turn t ?f ()] gets updated buff which is decreased duration. This function updates weight of buff
   if gives [?f] *)

val is_finished: t -> bool
(* Get a buff finished or not *)
