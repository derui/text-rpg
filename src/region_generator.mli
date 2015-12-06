(*
  A module provide an region generator that make
  region with given random state.
*)
open Core.Std

type t
(* A type of generator *)

val make: state:Random.State.t -> ability_generator:Ability_generator.t ->
  setting:Region_setting.t -> t
  (* Make a new generator with Random state. *)

val new_region: t -> Region_base.t
(* Generate an region which have randomized class and values. *)

