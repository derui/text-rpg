open Core.Std

let%spec "Helve region can contain abilities for stablity" =
  let module R = Region_base in
  let module B = Region_helve in
  let helve = new B.t {
    R.base_ratio = 0.1;
    attachable = [];
    max_abilities = 1;
    abilities = [];
  } in
  helve#get_region_type [@eq `Helve];
  List.mem helve#get_attachable `Agility [@true];
  List.mem helve#get_attachable `Dexterity [@true];
  List.length helve#get_attachable [@eq 2]
