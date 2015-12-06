open Core.Std
module R = Region_base

let%spec "Region setting can write to and load from a file" =
  let module S = Region_setting in
  let setting = {
    S.region_builtins = [
      (`Blade, {R.Builtin.ability = `Slash_attack;
                region_type = `Blade;
                attachable = []
               }
      )
    ];
  } in
  S.save setting "sample.sexp";
  let loaded = S.load "sample.sexp" |> Option.value ~default:S.empty in

  loaded.S.region_builtins [@eq setting.S.region_builtins]
