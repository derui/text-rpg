open Core.Std

let%spec "Sword should have 3 component to be able to attach" =
  let module W = Weapon_base in
  let module S = Weapon_sword in
  let w = S.make ~id:1L () in

  List.length w.W.components [@eq 3];
  List.find w.W.components ~f:(fun c -> Tuple.T2.get1 c = `Blade) [@eq Some((`Blade, 1))];
  List.find w.W.components ~f:(fun c -> Tuple.T2.get1 c = `Helve) [@eq Some((`Helve, 1))];
  List.find w.W.components ~f:(fun c -> Tuple.T2.get1 c = `Lower_guard) [@eq Some((`Lower_guard, 1))];
