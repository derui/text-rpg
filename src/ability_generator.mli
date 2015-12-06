(*
  A module provide an ability generator that make
  ability randomized with given random state.
*)
open Core.Std

type t
(* A type of generator *)

val make: state:Random.State.t -> setting:Ability_setting.t -> t
  (* Make a new generator with Random state. *)

val new_ability: ?target_class:Ability.ability_class -> t -> unit -> Ability.t
(* Generate an ability which have randomized class and values. *)

