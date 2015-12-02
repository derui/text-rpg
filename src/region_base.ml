open Core.Std

(* deduplicate attchable abilities between original and abilities of unique-per-region *)
let dedup_attachable origin region_unique =
  List.concat [origin;region_unique] |> List.dedup

class virtual region common = object (self)
  val mutable common_info = common
  val mutable extracted = false

  (* Get type of this region *)
  method virtual get_region_type: Region_common.region_type

  (* Get attchable ability class list for region-unique abilities.
     Implementing this method should.
  *)
  method virtual get_region_uniq_abilities: Ability.ability_class list

  (* Get list attachable ability classes. *)
  method get_attachable = 
    let cm = self#get_common in
    dedup_attachable cm.Region_common.attachable self#get_region_uniq_abilities

  method get_common : Region_common.t = common_info
(* Get value of this region *)

  method is_empty = extracted
  (* Query what this is already extracted *)

  (* Extract an ability from this. This method mark this as empty region.
     Empty region can not extract any ability from.
  *)
  method extract_ability: Ability.id -> Ability.t option = fun id ->
    if self#is_empty then None
    else
      let module C = Region_common in
      let module A = Ability in
      let cm = self#get_common in
      let ab = List.find cm.C.abilities ~f:(fun ab -> ab.A.id = id) in
      common_info <- {cm with C.abilities = []};
      extracted <- true;
      ab
end
