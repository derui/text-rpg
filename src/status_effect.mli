open Core.Std

type t [@@deriving sexp]
(* a type of effect *)

val make: element:Status_element.t -> weight:Float.t -> t
(* [make ~element ~weight] gets new effect with an [element] and [weight] to weight status. *)
