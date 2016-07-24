include Character

(* make character class which is kind of Actor. *)
let make id = function
  | Actor.Player ->
     (module struct
       module Character = Character_player
       let this = Character_player.make id
     end : Character_instance)
