open Core.Std

let%spec "Blade region should contain Slash_attack" =
  let module R = Region_base in
  let module B = Region_blade in
  let blade = new B.t {
    Region_common.id = 1L;
    base_ratio = 0.1;
    attachable = [`Slash_defence];
    max_abilities = 1;
    abilities = [];
  } in
  blade#get_region_type [@eq `Blade];
  List.mem blade#get_attachable `Slash_attack [@true];
  List.length blade#get_attachable [@eq 2]

let%spec "Blade region should not duplicate original ability" =
  let module R = Region_base in
  let module B = Region_blade in
  let blade = new B.t {
    Region_common.id = 1L;
    base_ratio = 0.1;
    attachable = [`Slash_attack];
    max_abilities = 1;
    abilities = [];
  } in
  List.mem blade#get_attachable `Slash_attack [@true];
  List.length blade#get_attachable [@eq 1]
