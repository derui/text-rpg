open Core.Std
module R = Region_base

class test_region common = object (self)
  inherit R.region common
  method get_region_type = `Blade
  method get_region_uniq_abilities = []
end

let%spec "Region should return None if give the ability id not owned" =
  let module A = Ability in
  let region = new test_region {
    Region_common.id = 1L;
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
  (region#extract_ability 2L) [@eq None]

let%spec "Region should return Some ability specified ability id" =
  let module A = Ability in
  let ab = {
      A.id = 1L;
      ability_class = `Slash_attack;
      value = 1.0;
      mergeability = A.Unmergeable
    } in
  let region = new test_region {
    Region_common.id = 1L;
    base_ratio = 0.1;
    attachable = [`Slash_defence];
    max_abilities = 1;
    abilities = [ab];
  } in
  (region#extract_ability 1L) [@eq Some(ab)];
  (region#is_empty) [@true]

let%spec "Region can not extract ability if already extracted" =
  let module A = Ability in
  let ab = {
      A.id = 1L;
      ability_class = `Slash_attack;
      value = 1.0;
      mergeability = A.Unmergeable
    } in
  let region = new test_region {
    Region_common.id = 1L;
    base_ratio = 0.1;
    attachable = [`Slash_defence];
    max_abilities = 1;
    abilities = [ab];
  } in
  (region#extract_ability 1L) [@eq Some(ab)];
  (region#extract_ability 1L) [@eq None]
