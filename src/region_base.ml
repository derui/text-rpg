open Core.Std

(* The type of region *)
type common = {
  base_ratio: Float.t;
  abilities: Ability.t list;
  max_abilities: Int.t;
  attachable: Ability.ability_class list;
} [@@deriving sexp]

type region_type = [`Blade | `Helve | `Lower_guard | `Broad_blade | `Shaft]
  [@@deriving sexp]

(* deduplicate attchable abilities between original and abilities of unique-per-region *)
let dedup_attachable origin region_unique =
  List.concat [origin;region_unique] |> List.dedup

class virtual region common = object (self)
  method virtual get_region_type: region_type
  (* Get type of this region *)

  (* Get attchable ability class list for region-unique abilities.
     Implementing this method should.
  *)
  method virtual get_region_uniq_abilities: Ability.ability_class list

  (* Get list attachable ability classes. *)
  method get_attachable = 
    let cm = self#get_common in
    dedup_attachable cm.attachable self#get_region_uniq_abilities

  method get_common : common = common
(* Get value of this region *)
end
