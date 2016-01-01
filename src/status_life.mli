open Core.Std

type t [@@deriving sexp]

val empty: t
(* Get an empty life status. *)

val current: t -> Float.t
(* [current t] gets the current value of life. *)

val max_life: t -> Float.t
(* [max_life t] gets the maximum quantity of life. *)

val change: t -> f:(Float.t -> Float.t) -> t
(* [change t ~f] gets the new life changed with {~f}. Life do not have minus quantity, if changed value is
   minus, this function returns 0.0 as life.
*)

val gain_maximum: t -> Float.t -> t
(* [gain_maximum t new_val] gets the new life setted new maximum life from [new_val]. *)
