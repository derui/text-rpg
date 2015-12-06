open Core.Std

include Region_common

(* deduplicate attchable abilities between original and abilities of unique-per-region *)
let dedup_attachable origin region_unique =
  List.concat [origin;region_unique] |> List.dedup

type t = {
  builtin: Builtin.t;
  common: Common.t;
}

let make ~builtin ~common = {builtin; common}

(* short hand to get region unique id *)
let region_id {common;_} = common.Common.id

let attachable_abilities t = 
  let module B = Builtin in
  let module C = Common in
  let builtin = t.builtin.B.attachable in
  dedup_attachable t.common.C.attachable builtin

(* Extract an ability from this. This method mark this as empty region.
   Empty region can not extract any ability from.
*)
let extract_ability t id =
  let module A = Ability in
  let module C = Common in
  List.find t.common.C.abilities ~f:(fun ab -> ab.A.id = id)
