open Core.Std
module R = Region_base
module I = Inventory
module A = Ability

let builtin = {
  R.Builtin.unique_ability = `Slash_attack;
  attachable = [];
  region_type = `Blade
}

let abilities = [{
  A.id = 1L;
  ability_class = `Slash_attack;
  value = 1.0;
  mergeability = A.Unmergeable
}]

let region = R.make ~builtin ~common:{
  R.Common.id = 1L;
  base_ratio = 0.1;
  max_abilities = 1;
  abilities;
}

let%spec "Inventory should contain region per id of region" =
  let inv = I.empty in
  let inv = I.add_region inv region in
  let inv = I.add_ability inv (List.nth_exn abilities 0) in

  I.Inventory.length inv.I.regions [@eq 1];
  I.Inventory.length inv.I.abilities [@eq 1]

let%spec "Inventory can find the item in the inventory" =
  let a = List.nth_exn abilities 0 in
  let inv = I.empty in
  let inv = I.add_region inv region in
  let inv = I.add_ability inv a in

  I.find_region inv region [@eq Some(region)];
  I.find_ability inv a [@eq Some(a)]

let%spec "Inventory can remove the item from the inventory" =
  let a = List.nth_exn abilities 0 in
  let inv = I.empty in
  let inv = I.add_region inv region in
  let inv = I.add_ability inv a in

  I.Inventory.length inv.I.regions [@eq 1];
  I.Inventory.length inv.I.abilities [@eq 1];

  let inv = I.remove_region inv region in
  I.Inventory.length inv.I.regions [@eq 0]
