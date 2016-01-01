open Core.Std

type t [@@deriving sexp]
(* the type of basement status  *)

val empty: t
(* [empty] gets an empty basement status *)

val update: t -> Status_element.t -> t
(* [update t element] gets an updated basement parameters with [element].
   If a kind of [element] is not found in [t], gets original status.
*)

val get_element: t -> Status_types.kind -> Status_element.t option
(* [get_element t kind] gets an element in a basement. *)
