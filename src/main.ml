
let () =
  [%sexp_of: Ability.t] {
    Ability.id = 1L;
    ability_class = `Slash_attack;
    value = 0.0;
    mergeability = Ability.Mergeable Ability.Addition
  } |> ignore
