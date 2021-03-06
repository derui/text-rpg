(* Provide common region information and types. *)
open Core.Std

(* The inner identify of region.
   Using this to specify operations such as remove/attach/merge and others. *)
type id = Int64.t [@@deriving sexp]

type region_type = [`Blade | `Helve | `Lower_guard | `Broad_blade | `Shaft]
  [@@deriving sexp]

module Common = struct
(* The type of region *)
  type t = {
    id: id;
    base_ratio: Float.t;
    abilities: Ability.t list;
    max_abilities: Int.t;
  } [@@deriving sexp]

  let empty id = {
    id;base_ratio = 0.0;abilities = []; max_abilities = 0;
  }

end

(* The type of built-in information per region. This type should not make hand-on and should load
   from setting file.
*)
module Builtin = struct
  type t = {
    unique_ability: Ability.ability_class;
    region_type: region_type;
    attachable: Ability.ability_class list;
  }  [@@deriving sexp]
end
