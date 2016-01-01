open Core.Std
  
(* Element is minimum parts of status. Each elements has a kind of element and quantity of kind.  *)
type t = {
  kind: Status_types.kind;
  quantity: Float.t;
} [@@deriving sexp]

let make ~kind ~quantity = {kind; quantity}
let update t quantity = {t with quantity = quantity}

let value {quantity;_} = quantity
let kind {kind;_} = kind
