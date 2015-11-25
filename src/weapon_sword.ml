open Core.Std
module W = Weapon_base

type t = W.t

(* Make a sword template. Returning result from this function must append any regions after.
*)
let make_sword () = {
  W.regions = [];
  components = [(`Blade, 1);(`Helve, 1);(`Lower_guard, 1)]
}
