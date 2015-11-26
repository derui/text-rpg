open Core.Std

(* The type of region *)
type common = {
  base_ratio: Float.t;
  abilities: Ability.t list;
  max_abilities: Int.t;
  attachable: Ability.ability_class list;
} [@@deriving sexp]

type region_type = [`Blade | `Helve | `Lower_guard | `Double_edge_blade]
  [@@deriving sexp]

class virtual region common = object
  method virtual get_region_type: region_type
  (* Get type of this region *)

  method virtual get_attachable: Ability.ability_class list
  (* Get list attachable ability classes.
     Implementing this method should be concatted attachable in common and
     unique attachable ability class based on region_type.
  *)

  method get_common : common = common
  (* Get value of this region *)
end
