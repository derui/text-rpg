open Core.Std

type t [@@deriving sexp]

val make: kind:Status_types.kind -> quantity:Float.t -> t
(* Make an element with kind of element and quantity *)

val value: t -> Float.t
(* [value t] gets the value of the element [t]. *)

val kind: t -> Status_types.kind
(* [kind t] gets the kind of [t] *)

val update: t -> Float.t -> t
(* Update the element with new quantity *)
