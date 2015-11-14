open Core.Std

type ability_class = [`Slash_attack | `Slash_defence]
  [@@deriving sexp]

type merge_type = Add | Multi | NotMerge
    [@@deriving sexp]

type t = {
  ability_class:ability_class;
  value: Float.t;
  merge_type: merge_type;
} [@@deriving sexp]
