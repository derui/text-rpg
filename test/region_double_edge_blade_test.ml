open Core.Std

let%spec "Double edge brade region should contain Slash and Smash attack" =
  let module R = Region_base in
  let module B = Region_double_edge_blade in
  let blade = new B.t {
    R.base_ratio = 0.1;
    attachable = [`Slash_defence];
    max_abilities = 1;
    abilities = [];
  } in
  blade#get_region_type [@eq `Double_edge_blade];
  List.mem blade#get_attachable `Slash_attack [@true];
  List.mem blade#get_attachable `Smash_attack [@true];
  List.length blade#get_attachable [@eq 3]
