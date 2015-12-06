open Core.Std
module R = Region_base
module S = Region_setting

type t = {
  state: Random.State.t;
  ability_generator: Ability_generator.t;
  setting: Region_setting.t;
}

let make ~state ~ability_generator ~setting  =
  {state;ability_generator;setting}

let int_range state bound = Random.State.int state bound

(* Pick up builtin instance for new region. Builtin pickuped from this provide
   type of target region.
*)
let new_builtin {state;setting;_} =
  let region = List.length setting.S.region_builtins |> int_range state in
  let region = List.nth_exn setting.S.region_builtins region in
  Tuple2.get2 region

(* Get ability class list to be used to create abilities attached region. *)
let new_attachable freq state =
  let rand = Random.State.float state 1.0 in
  let rec pickup prob = function
    | [] -> None
    | [f] -> Some (f)
    | ((freq, _) as f) :: rest -> if prob +. freq >= rand then Some(f)
      else pickup (prob +. freq) rest
  in
  match pickup 0.0 freq with
  | None -> failwith "Frequency must have more than 0"
  | Some f -> f

(* Get a new common information for new region. *)
let new_common builtin {state;setting;ability_generator} =
  let region_type = builtin.R.Builtin.region_type in
  let _, freq = List.find_exn setting.S.region_attachable_freq ~f:(fun (typ, _) -> typ = region_type) in
  let max_abilities = int_range state setting.S.max_attachable_count |> min 1 in
  let current_abilities_count = min 1 (Random.State.int state max_abilities) in
  let target_abilities = List.range 0 current_abilities_count |> List.map ~f:(fun _ ->
    new_attachable freq state
  ) |> List.map ~f:Tuple2.get2 in
  let id = Random.State.int64 state Int64.max_value in
  {
    R.Common.id = id;
    max_abilities;
    base_ratio = min 0.5 (Random.State.float state 1.0);
    abilities = List.map target_abilities ~f:(fun cls ->
      Ability_generator.new_ability ~target_class:cls ability_generator ()
    )
  }
  
let new_region t =
  let builtin = new_builtin t in
  {
    R.common = new_common builtin t;
    builtin;
  }
