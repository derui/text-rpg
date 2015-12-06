open Core.Std
module A = Ability
module S = Ability_setting

type t = {
  state: Random.State.t;
  setting: Ability_setting.t;
}

let make ~state ~setting =
  {state;setting}

let int_range state bound = Random.State.int state bound

let merge_type = [A.Addition;A.Multiplication]
let mergeability merge_type = [A.Mergeable (merge_type);A.Unmergeable]

let new_ability ?target_class {state;setting} () =
  let merge_type = List.nth_exn merge_type (int_range state 2) in
  let mergeability = List.nth_exn (mergeability merge_type) (int_range state 2) in
  let value = Random.State.float state 100.0 in
  let ability_class = List.nth_exn [setting.S.mergeable_abilities;
                                    setting.S.unmergeable_abilities
                                   ] (int_range state 2) in
  let ability_class = List.nth_exn ability_class (List.length ability_class |> int_range state) in
  let id = Random.State.int64 state Int64.max_value in
  {A.id = id;
   ability_class;
   mergeability;
   value;
  }
  

