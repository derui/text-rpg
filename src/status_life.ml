open Core.Std

open Status_types

(* Life have current life and maximum life as element having kind of Life. *)
type t = {
  element: Status_element.t;
  current: Float.t;
} [@@deriving sexp]

let empty = {
  element = Status_element.make ~kind:Life ~quantity:0.0;
  current = 0.0;
}

let current {current} = current
let max_life {element;_} = Status_element.value element

let change t ~f =
  let new_val = f t.current in
  {t with current = Float.max 0.0 new_val}

let gain_maximum t v = {t with element = Status_element.update t.element v}
