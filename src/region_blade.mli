
(* A class of region that a blade as sword. *)
class t : Region_base.common -> object
  method get_region_type: Region_base.region_type
  (* Get type of this region *)

  method get_attachable: Ability.ability_class list
  (* Get list attachable ability classes.
     Implementing this method should be concatted attachable in common and
     unique attachable ability class based on region_type.
  *)

  method get_common: Region_base.common
(* Get value of this region *)
end
