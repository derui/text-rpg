include Character

(* make character class which is kind of Actor. *)
let make (module G : Actor_id.Generator_instance) = function
  | Actor.Player ->
     let id = G.Generator.gen G.this () in
     (module struct
       module Character = Character_player
       let this = Character_player.make id
     end : Character_instance)
