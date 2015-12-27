open Core.Std
module S = Status

let%spec "Buff pass over a turn with function manipulate weight" =
  let buff = {
    S.Buff.element = {
      S.Element.kind = S.Vitality;
      quantity = 1.0;
    };
    weight = 1.5;
    duration = 10
  } in
  let buff = S.Buff.pass_turn buff () in
  buff.S.Buff.duration [@eq 9];
  let buff = S.Buff.pass_turn buff ~f:(fun w -> w -. 0.5) () in
  buff.S.Buff.duration [@eq 8];
  buff.S.Buff.weight [@eq 1.0]

let%spec "Buff can return it finished or not" =
  let buff = {
    S.Buff.element = {
      S.Element.kind = S.Vitality;
      quantity = 1.0;
    };
    weight = 1.5;
    duration = 1
  } in
  S.Buff.is_finished buff [@false];

  let buff = S.Buff.pass_turn buff () in
  S.Buff.is_finished buff [@true]
