
(* make character class which is kind of Actor. *)
let make id = function
  | Actor.Player -> new Character_player_impl.t(id)
