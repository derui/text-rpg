open Core.Std
module W = Weapon_base

type t = W.t

(* Make a axe template. Returning result from this function must append any regions after.
*)
let make () = {
  W.regions = [];
  components = [(`Broad_blade, 2);(`Shaft, 1)]
}
