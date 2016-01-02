open Core.Std

include Status_types

(* Element is minimum parts of status. Each elements has a kind of element and quantity of kind.  *)
module Element = Status_element

(* Life have current life and maximum life as element having kind of Life. *)
module Life = Status_life

(* Status is actor's basement states. This alway have nearly all state of kind of type kind. *)
module Base = Status_base

(* Element is an addition for status. This aggregate ability's values. *)
module Effect = Status_effect

(* Buff is an buff/debuff to actor. *)
module Buff = Status_buff
