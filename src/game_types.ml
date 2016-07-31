open Sdlcaml.Std
  
type event = Structures.Events.t

module Scene = struct
  type typ =
      Base_camp

  type transition =
      Stay
    | Transition of typ

  exception Finished
(* Finished all scene, then program will quit. *)
end
