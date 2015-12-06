open Core.Std
module R = Region_base
module C = Region_common

type component = Region_common.region_type * int [@@deriving sexp]
(* A component of the weapon. Having component region type and count are attachable to a
   weapon.
*)

(* The type of weapon *)
type t = {
  regions: Region_base.t list;
  (* Regions constructed a weapon *)
  components: component list;
(* Components defines attachable region type and count. *)
} [@@deriving sexp]

(* A simple wrapper making Region. *)
let make ?(regions=[]) ~components () = {
  regions;
  components;
}

(* detach region from weapon. *)
let detach_region t region_id =
  let find_region region = R.region_id region = region_id in
  let region = List.find t.regions ~f:find_region in
  (region, {t with regions = List.filter t.regions ~f:(Fn.compose not find_region)})
