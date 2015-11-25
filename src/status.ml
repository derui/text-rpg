open Core.Std

(* A status for any object such as monster or weapon.
   This is used to show status on the menu and calculate damages.
*)
type t = {
  slash_attack: Float.t;
  smash_attack: Float.t;
  lunge_attack: Float.t;

  slash_defence: Float.t;
  smash_defence: Float.t;
  lunge_defence: Float.t;

  dexterity: Float.t;
  agility: Float.t;
}
[@@deriving sexp]
