open Core.Std

type kind =
    Slash_attack | Smash_attack | Lunge_attack
  | Slash_defence | Smash_defence | Lunge_defence
  | Vitality | Dexterity | Agility
  | Life 
      [@@deriving sexp]

(* The module to store value with kind as key *)
module KindMap = Map.Make(struct
  type t = kind
  let t_of_sexp = [%of_sexp: kind]
  let sexp_of_t = [%sexp_of: kind]
  let compare = compare
end)

(* Element is minimum parts of status. Each elements has a kind of element and quantity of kind.  *)
module Element = struct
  type t = {
    kind: kind;
    quantity: Float.t;
  } [@@deriving sexp]

  let make ~kind ~quantity = {kind; quantity}
  let update t quantity = {t with quantity = quantity}
end

(* Life have current life and maximum life as element having kind of Life. *)
module Life = struct
  type t = {
    element: Element.t;
    current: Float.t;
  } [@@deriving sexp]

  let empty = {
    element = Element.make ~kind:Life ~quantity:0.0;
    current = 0.0;
  }
end

(* Status is actor's basement states *)
module Status = struct
  type t = Element.t list [@@deriving sexp]

  let empty = []
end

(* Element is an addition for status. This aggregate ability's values. *)
module Effect = struct
  type t = {
    element: Element.t;
    weight: Float.t;
  } [@@deriving sexp]
end

(* Buff is an buff/debuff to actor. *)
module Buff = struct
  type t = {
    element: Element.t;
    weight: Float.t;
    duration: Int.t;
  }  [@@deriving sexp]
end
