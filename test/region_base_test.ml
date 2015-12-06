open Core.Std
module R = Region_base

let builtin = {
  R.Builtin.ability = `Slash_attack;
  attachable = [];
  region_type = `Blade
}

let%spec "Region should return None if give the ability id not owned" =
  let module A = Ability in
  let region = R.make ~builtin ~common:{
    R.Common.id = 1L;
    base_ratio = 0.1;
    attachable = [`Slash_defence];
    max_abilities = 1;
    abilities = [{
      A.id = 1L;
      ability_class = `Slash_attack;
      value = 1.0;
      mergeability = A.Unmergeable
    }];
  } in
  (R.extract_ability region 2L) [@eq None]

let%spec "Region should return Some ability specified ability id" =
  let module A = Ability in
  let ab = {
      A.id = 1L;
      ability_class = `Slash_attack;
      value = 1.0;
      mergeability = A.Unmergeable
    } in
  let region = R.make ~builtin ~common:{
    R.Common.id = 1L;
    base_ratio = 0.1;
    attachable = [`Slash_defence];
    max_abilities = 1;
    abilities = [ab];
  } in
  (R.extract_ability region 1L) [@eq Some(ab)]
