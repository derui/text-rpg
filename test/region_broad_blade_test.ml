open Core.Std

let%spec "Broad brade region should contain Slash and Smash attack" =
  let module R = Region_base in
  let module B = Region_broad_blade in
  let blade = new B.t {
    R.base_ratio = 0.1;
    attachable = [`Slash_defence];
    max_abilities = 1;
    abilities = [];
  } in
  blade#get_region_type [@eq `Broad_blade];
  List.mem blade#get_attachable `Slash_attack [@true];
  List.mem blade#get_attachable `Smash_attack [@true];
  List.length blade#get_attachable [@eq 3]
