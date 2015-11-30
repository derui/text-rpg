open Core.Std

let%spec "Lower Guard region can contain all defence abilities" =
  let module R = Region_base in
  let module B = Region_lower_guard in
  let lower_guard = new B.t {
    Region_common.id = 1L;
    base_ratio = 0.1;
    attachable = [];
    max_abilities = 1;
    abilities = [];
  } in
  lower_guard#get_region_type [@eq `Lower_guard];
  List.mem lower_guard#get_attachable `Slash_defence [@true];
  List.mem lower_guard#get_attachable `Smash_defence [@true];
  List.length lower_guard#get_attachable [@eq 2]
