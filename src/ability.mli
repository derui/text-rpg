open Core.Std

(* Types of ability *)
type ability_class = [`Slash_attack | `Slash_defence]
  [@@deriving sexp]

(* Type to merge each abilities.  *)
type merge_type = Add | Multi | NotMerge
    [@@deriving sexp]

(* Common properties of an ability *)
type t = {
  ability_class:ability_class;
  value: Float.t;
  merge_type: merge_type;
} [@@deriving sexp]
