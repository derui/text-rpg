open Core.Std

let%spec "Axe should have 2 component to be able to attach" =
  let module W = Weapon_base in
  let module A = Weapon_axe in
  let w = A.make () in

  List.length w.W.components [@eq 2];
  List.find w.W.components ~f:(fun c -> Tuple.T2.get1 c = `Broad_blade) [@eq Some((`Broad_blade, 2))];
  List.find w.W.components ~f:(fun c -> Tuple.T2.get1 c = `Shaft) [@eq Some((`Shaft, 1))];
