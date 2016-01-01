open Core.Std

(* Element is an addition for status. This aggregate ability's values. *)
type t = {
  element: Status_element.t;
  weight: Float.t;
} [@@deriving sexp]

let make ~element ~weight = {element; weight}
