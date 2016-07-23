open Core.Std
module T = Game_types.Scene

include Scene_intf

module type Scene_instance = sig
  module Scene_intf : Scene_intf
  val this : Scene_intf.t
end

module Scene_base_camp = struct
  type t = int
  let make = Fn.const 0
  let handle_key t k = failwith ""
  let render t env w = failwith ""
end

let create env = function
  | T.Base_camp -> (module struct
    module Scene_intf = Scene_base_camp
    let this = Scene_base_camp.make env
  end : Scene_instance)
