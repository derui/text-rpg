open Core.Std

type component = Region_base.region_type * int [@@deriving sexp]
(* A component of the weapon. Having component region type and count are attachable to a
   weapon.
*)

(* The type of weapon *)
type t = {
  regions: Region_base.region list;
  (* Regions constructed a weapon *)
  components: component list;
(* Components defines attachable region type and count. *)
}

