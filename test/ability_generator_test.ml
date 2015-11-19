open Core.Std

let%spec "Ability generator generate an ability via given State" =
  let module A = Ability in
  let module S = Ability_setting in
  let state = Random.State.make [||] in
  let gen = Ability_generator.make ~state ~setting:{
    S.mergeable_abilities = [`Slash_attack];
    unmergeable_abilities = [`Slash_defence]
  } () in

  let ab = Ability_generator.ability gen in
  Printf.printf "%s\n" (Sexp.to_string ([%sexp_of:A.t] ab));
  ab.A.ability_class [@eq `Slash_attack];
  ab.A.value [@eq 3.1397619144334103];
  ab.A.mergeability [@eq A.Mergeable(A.Addition)];
