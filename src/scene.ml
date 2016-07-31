open Core.Std
module T = Game_types.Scene
module Sd = Sdlcaml.Std

module type Scene = sig
  type t

  val make: Environment.t -> t
  (* [make env] get the new scene created from [env] *)

  val handle_event: t -> Game_types.event -> t Lwt.t
  (* [handle_key t env key] perform key handling with [env] and [t].
     Instance of [t] is holded in [env], so you can hold any mutable value in [t].
  *)

  val render: t -> Environment.t -> Sd.Window.t -> unit Lwt.t
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

module type Scene_instance = sig
  module Scene: Scene
  val this : Scene.t
end

module Scene_base_camp = struct
  type t = int
  let make = Fn.const 0
  let handle_event t e =
    let module E = Sd.Structures.Events in
    let module K = Sd.Structures.Keysym in
    match e with
    | E.Keyboard k -> begin
       let {E.KeyboardEvent.state;keysym;_} = k in
       let module C = Sd.Flags.Sdl_scancode in 

       match keysym.K.scancode with
       | C.SDL_SCANCODE_Q -> Lwt.return 1
       | _ -> Lwt.return t
    end
    | _ -> Lwt.return t

  let render t env w =
    let module W = Sd.Window in
    let module C = Sd.Structures.Color in
    let module F = Sd.Flags.Sdl_pixel_format_enum in
    let s = W.get_surface w in
    let open Sd.Types.Result.Monad_infix in 
    let module T = Sd.Types.Result in 
    let _ = Sd.Surface.fill_rect ~dst:s ~color:(Sd.Timer.get_ticks ()) ()
            >>= fun () -> W.update_surface w |> T.return in
    Lwt.return ()

  let update t env =
    if t = 1 then Lwt.fail Game_types.Scene.Finished
    else Lwt.return (t, Game_types.Scene.Stay)
end

let create env = function
  | T.Base_camp -> (module struct
    module Scene = Scene_base_camp
    let this = Scene_base_camp.make env
  end : Scene_instance)
