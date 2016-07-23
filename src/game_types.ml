open Sdlcaml.Std
  
type key = Structures.Events.KeyboardEvent.t

module Scene = struct
  type typ = Base_camp

  type transition =
      Stay
    | Transition of typ
end
