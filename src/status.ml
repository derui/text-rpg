open Core.Std

include Status_types

(* Element is minimum parts of status. Each elements has a kind of element and quantity of kind.  *)
module Element = Status_element

(* Life have current life and maximum life as element having kind of Life. *)
module Life = Status_life

(* Status is actor's basement states. This alway have nearly all state of kind of type kind. *)
module Status = struct
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
end

(* Element is an addition for status. This aggregate ability's values. *)
module Effect = Status_effect

(* Buff is an buff/debuff to actor. *)
module Buff = struct
  type t = {
    element: Element.t;
    weight: Float.t;
    duration: Int.t;
  }  [@@deriving sexp]

  (* Pass over a turn from a buff. *)
  let pass_turn t ?f () =
    match f with
    | None -> {t with duration = t.duration - 1}
    | Some f -> {t with duration = t.duration - 1; weight = f t.weight}

  (* Get a buff finished or not *)
  let is_finished t = t.duration <= 0
end
