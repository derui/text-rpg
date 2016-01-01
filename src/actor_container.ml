(* Provide actor container that contains actors and characters, and objects relationship for actor *)

open Core.Std

module Character_map = Map.Make(struct
  type t = Actor.Id.t

  let compare = Actor.Id.compare
  let t_of_sexp = [%of_sexp: Actor.Id.t]
  let sexp_of_t = [%sexp_of: Actor.Id.t]
end)

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

let add_actor t actor = {
  t with actors = actor :: t.actors
}
