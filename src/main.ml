
let () =
  [%sexp_of: Ability.t] {
    Ability.ability_class = `Slash_attack;
    value = 0.0;
    mergeable = Ability.Mergeable Ability.Addition
  } |> ignore
