open Core.Std
module T = Game_types.Scene
module Sd = Sdlcaml.Std

module S = struct
  type t = {
    gui_list: Gui_list.t;
    finished: bool;
  }
  let make env context =
    let rect = {Sd.Structures.Rect.x = 100; y = 50; w = 200; h = 300} in
    let items = [(module struct
      module Item = struct
        type t = unit

        let select = ignore
        let name () = "sample"
      end
      let this = ()
    end : Gui_list.Item_instance)] in
    {
      gui_list = Gui_list.make ~rect ~items ~item_height:20 ~font:context.Rendering_context.font;
      finished = false;
    }

  let handle_event t e =
    let module E = Sd.Structures.Events in
    let module K = Sd.Structures.Keysym in
    match e with
    | E.Keyboard k -> begin
      let {E.KeyboardEvent.state;keysym;_} = k in
      let module C = Sd.Flags.Sdl_scancode in

      match keysym.K.scancode with
      | C.SDL_SCANCODE_Q -> Lwt.return {t with finished = true}
      | C.SDL_SCANCODE_UP -> 
        Lwt.(return {t with gui_list = Gui_list.move_cursor t.gui_list `Up})
      | C.SDL_SCANCODE_DOWN -> 
        Lwt.(return {t with gui_list = Gui_list.move_cursor t.gui_list `Down})
      | _ -> Lwt.return t
    end
    | _ -> Lwt.return t

  let render t env context =
    let module R = Sd.Renderer in
    let module RE = Sd.Structures.Rect in
    let rect = {RE.h = 100; w = 200; x = 10; y = 40} in
    let renderer = context.Rendering_context.renderer in
    Lwt.(Gui_list.render t.gui_list ~renderer >>= fun () ->
         R.draw_rect ~renderer ~rect |> return >>= fun _ -> return_unit)

  let update t env =
    if t.finished then Scene_util.finish ()
    else Lwt.return (t, Game_types.Scene.Stay)
end

include S
