(* Provide actor container that contains actors and characters, and objects relationship for actor *)

open Core.Std

module Character_map = Map.Make(Actor.Id)

type t = {
  (* the array to contain actors *)
  actors: Actor.t list;
  characters: Character.t Character_map.t;
}

(* Get an empty actor_container *)
let empty = {
  actors = [];
  characters = Character_map.empty;
}

(* add an actor and character implementation to the actor container *)
let add_actor t actor =
  let id = Actor.id actor in
  let ch = Actor.kind actor |> Character_maker.make id in
  {
    actors = actor :: t.actors;
    characters = Character_map.add t.characters ~key:id ~data:ch
  }
