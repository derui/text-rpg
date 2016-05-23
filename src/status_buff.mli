open Core.Std
type depression = weight:Float.t -> duration:Int.t -> Float.t

(* Buff is an buff/debuff to actor. *)
type t [@@deriving sexp]

val make: element:Status_element.t -> weight: Float.t -> duration: Int.t -> t
(* [make ~element ~weight ~duration] gets a new buff with parameters *)

val pass_turn: t -> ?f:depression -> unit -> t
(* [pass_turn t ?f ()] gets updated buff which is decreased duration. This function updates weight of buff
   if gives [?f] *)

val weight: t -> Float.t
(* [weight t] gets current weight. *)

val is_finished: t -> bool
(* Get a buff finished or not *)
