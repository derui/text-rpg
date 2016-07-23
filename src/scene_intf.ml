module Sd = Sdlcaml.Std

module type Scene_intf = sig
  type t

  val make: Environment.t -> t
  (* [make env] get the new scene created from [env] *)

  val handle_key: t -> Game_types.key -> (t * Game_types.Scene.transition) Lwt.t
  (* [handle_key t env key] perform key handling with [env] and [t].
     Instance of [t] is holded in [env], so you can hold any mutable value in [t].
  *)

  val render: t -> Environment.t -> Sd.Window.t -> unit Lwt.t
  (* [render t env window] perform scene rendering with [env] and [t].
     Notice that [render] and [handle_key] functions are run on each another thread
     always, so user that implement some scene should be very carefully it.
  *)
end
