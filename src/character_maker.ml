include Character

(* make character class which is kind of Actor. *)
let make actor = function
  | Actor.Player -> (module struct
    module Character = Character_player
    let this = Character_player.make actor
  end : Character_instance)
