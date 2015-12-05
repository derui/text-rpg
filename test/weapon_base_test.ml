open Core.Std
module R = Region_base

class test_region common = object (self)
  inherit R.region common
  method get_region_type = `Blade
  method get_region_uniq_abilities = []
end

let%spec "Weapon can detach region having self" =
  let module A = Ability in
  let module W = Weapon_base in
  let module C = Region_common in
  let regions = [new test_region {
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
  }] in
  let w = W.make ~regions ~components:[] () in

  let region, w = W.detach_region w 1L in
  region [@eq Some (List.nth_exn regions 0)];
  List.length w.W.regions [@eq 0]


let%spec "Weapon can detach region not contained and get None as region" =
  let module A = Ability in
  let module W = Weapon_base in
  let module C = Region_common in
  let regions = [new test_region {
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
  }] in
  let w = W.make ~regions ~components:[] () in

  let region, w = W.detach_region w 2L in
  region [@eq None];
  List.length w.W.regions [@eq 1]

