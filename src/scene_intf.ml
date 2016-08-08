open Core.Std

(* Interface of some scene in this game *)
module type Scene = sig
  type t

  val make: Environment.t -> Rendering_context.t -> t
  (* [make env] get the new scene created from [env] *)

  val handle_event: t -> Game_types.event -> t Lwt.t
  (* [handle_key t env key] perform key handling with [env] and [t].
     Instance of [t] is holded in [env], so you can hold any mutable value in [t].
  *)

  val render: t -> Environment.t -> Rendering_context.t -> unit Lwt.t
  (* [render t env window] perform scene rendering with [env] and [t].
     Notice that [render] and [handle_key] functions are run on each another thread
     always, so user that implement some scene should be very carefully it.
  *)

  val update: t -> Environment.t -> (t * Game_types.Scene.transition) Lwt.t
  (* [update t env] execute several logics of the [t].
     Notice this function only called per-frame, default 60fps.
     But you should not write any logic in [update] if no have any logic.
  *)
end

(* Interface of instance of the scene. *)
module type Scene_instance = sig
  module Scene: Scene
  val this : Scene.t
end
