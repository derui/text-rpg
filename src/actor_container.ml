(* Provide actor container that contains pairs of actor and character, and objects relationship for actor.
   Container having actor and character set has functions to add and remove, and find for actor set.
*)

open Core.Std

module Character_map = Map.Make(Actor_id)

type actor_pair = Actor.t * (module Character.Character_instance)

type t = actor_pair Character_map.t

(* Get an empty actor_container *)
let empty = Character_map.empty

(* add an actor and character implementation to the actor container *)
let add t actor =
  let id = Actor.id actor in
  let ch = Actor.kind actor |> Character_maker.make id in
  Character_map.add t ~key:id ~data:(actor, ch)

let remove t actor_id =
  let target = Character_map.find t actor_id in
  (Character_map.remove t actor_id, target)
