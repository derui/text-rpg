open Core.Std

include Region_common

type t = {
  builtin: Builtin.t;
  common: Common.t;
} [@@deriving sexp]

let make ~builtin ~common = {builtin; common}

(* short hand to get region unique id *)
let region_id {common;_} = common.Common.id

let attachable_abilities t = let module B = Builtin in t.builtin.B.attachable

(* Extract an ability from this. This method mark this as empty region.
   Empty region can not extract any ability from.
*)
let extract_ability t id =
  let module A = Ability in
  let module C = Common in
  List.find t.common.C.abilities ~f:(fun ab -> ab.A.id = id)
