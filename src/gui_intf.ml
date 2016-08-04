(* Interface of some GUI component in this game *)
module type Gui = sig
  type t

  type operations

  val handle_operations: t -> operation:operations -> t Lwt.t
(* Handle some operation that defined in this interface *)

  val render: t -> renderer:Sdlcaml.Std.Renderer.t -> unit Lwt.t
(* Render GUI into the [renderer]. *)
end

(* Interface of instance a GUI component. Function that make some instance is
   not include interface, so each GUI should provide function/functions to make instance
   as it.
*)
module type Gui_instance = sig
  module Gui: Gui

  val this: Gui.t
end