open Core.Std
module T = Game_types.Scene
module Sd = Sdlcaml.Std

module S = struct
  type t = int
  let make _ = 0
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

  let render t env context =
    let module R = Sd.Renderer in
    let module RE = Sd.Structures.Rect in
    let rect = {RE.h = 100; w = 200; x = 10; y = 40} in
    let renderer = context.Rendering_context.renderer in
    let _ = R.draw_rect ~renderer ~rect in
    Lwt.return ()

  let update t env =
    if t = 1 then Scene_util.finish ()
    else Lwt.return (t, Game_types.Scene.Stay)
end

include S
