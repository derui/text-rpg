open Core.Std
module T = Game_types.Scene
module Sd = Sdlcaml.Std

include Scene_intf

let create env context = function
  | T.Base_camp -> (module struct
    module Scene = Scene_base_camp
    let this = Scene_base_camp.make env context
  end : Scene_instance)
