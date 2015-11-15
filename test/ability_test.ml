open Core.Std

let%spec "Ability should merge abilities which apply offset for parameter" =
  let module A = Ability in
  let ab = {
    A.ability_class = `Slash_attack;
    value = 2.0;
    mergeable = A.Mergeable (A.Addition)
  } in
  let offset = A.abilities_to_offset ~target_class:`Slash_attack [ab] in
  offset.A.amount_addition [@eq 2.0];
  offset.A.amount_multiple [@eq 1.0];
  offset.A.amount_unmergeable [@eq None]
