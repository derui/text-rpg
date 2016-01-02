open Core.Std
module Element = Status_element

open Status_types

type t = Element.t list [@@deriving sexp]

let empty = [
  Element.make ~kind:Slash_attack ~quantity:0.0;
  Element.make ~kind:Smash_attack ~quantity:0.0;
  Element.make ~kind:Lunge_attack ~quantity:0.0;
  Element.make ~kind:Slash_defence ~quantity:0.0;
  Element.make ~kind:Smash_defence ~quantity:0.0;
  Element.make ~kind:Lunge_defence ~quantity:0.0;
  Element.make ~kind:Vitality ~quantity:0.0;
  Element.make ~kind:Dexterity ~quantity:0.0;
  Element.make ~kind:Agility ~quantity:0.0;
]

let update t e =
  let module E = Status_element in
  match List.find t ~f:(fun el -> E.kind el = E.kind e) with
  | None -> t
  | Some el ->
     let t = List.filter t ~f:(fun el' -> E.kind el <> E.kind el') in
     e :: t

let get_element t kind = let module E = Status_element in List.find t ~f:(fun el -> E.kind el = kind) 
