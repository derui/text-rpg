module Sd = Sdlcaml.Std

module type Scene_intf = sig
  type t
  val make: Environment.t -> t
  val handle_key: t -> Type.key -> t * Scene_types.transition
  val render: t -> Sd.Window.t -> unit
end
