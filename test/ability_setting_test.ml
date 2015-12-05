open Core.Std

let%spec "Ability setting can write to and load from a file" =
  let module S = Ability_setting in
  let setting = {
    S.mergeable_abilities = [`Slash_attack];
    unmergeable_abilities = [`Slash_defence]
  } in
  S.save setting "sample.sexp";
  let loaded = S.load "sample.sexp" |> Option.value ~default:S.empty in

  loaded.S.mergeable_abilities [@eq [`Slash_attack]];
  loaded.S.unmergeable_abilities [@eq [`Slash_defence]]
