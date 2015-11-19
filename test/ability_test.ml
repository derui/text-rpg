open Core.Std

let%spec "Ability should merge abilities which apply offset for parameter" =
  let module A = Ability in
  let ab = {
    A.ability_class = `Slash_attack;
    value = 2.0;
    mergeability = A.Mergeable (A.Addition)
  } in
  let offset = A.abilities_to_offset ~target_class:`Slash_attack [ab] in
  offset.A.amount_addition [@eq 2.0];
  offset.A.amount_multiple [@eq 1.0];
  offset.A.amount_unmergeable [@eq None]

let%spec "Ability can merge abilities which contains another mergeable" =
  let module A = Ability in
  let ab_addition = {
    A.ability_class = `Slash_attack;
    value = 2.0;
    mergeability = A.Mergeable A.Addition
  } in
  let ab_multiplication = {
    A.ability_class = `Slash_attack;
    value = 3.0;
    mergeability = A.Mergeable A.Multiplication
  } in
  let offset = A.abilities_to_offset ~target_class:`Slash_attack [ab_addition;ab_multiplication] in
  offset.A.amount_addition [@eq 2.0];
  offset.A.amount_multiple [@eq 3.0];
  offset.A.amount_unmergeable [@eq None]

let%spec "Ability should only merge specified ability_class" =
  let module A = Ability in
  let ab_atk = {
    A.ability_class = `Slash_attack;
    value = 2.0;
    mergeability = A.Mergeable A.Addition
  } in
  let ab_def = {
    A.ability_class = `Slash_defence;
    value = 3.0;
    mergeability = A.Mergeable A.Addition
  } in
  let offset = A.abilities_to_offset ~target_class:`Slash_attack [ab_atk;ab_def] in
  offset.A.amount_addition [@eq 2.0];
  offset.A.amount_multiple [@eq 1.0];
  offset.A.amount_unmergeable [@eq None]