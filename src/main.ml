module S = Sdlcaml.Std
open Core.Std

let fps = Int32.(1000l / 60l)

let render ~window ~env ~current_scene () =
  let open Lwt in 
  let (module S : Scene.Scene_instance) = current_scene in
  S.Scene.render S.this env window

let with_sdl f =
  let module F = S.Flags.Sdl_init_flags in
  S.Init.init [F.SDL_INIT_VIDEO;F.SDL_INIT_TIMER;F.SDL_INIT_EVENTS];
  protect ~f ~finally:S.Init.quit

let () =

  with_sdl (fun () ->
    let module F = S.Flags.Sdl_window_flags in
    let window = S.Window.create ~title:"Text RPG" ~x:0 ~y:0 ~w:640 ~h:480 ~flags:[] in
    protect ~f:(fun () ->

      let env = Environment.make () in
      let module F = S.Flags.Sdl_renderer_flags in
      S.Types.Result.(
        S.Renderer.create ~window ~flags:[F.SDL_RENDERER_ACCELERATED] () >>= fun renderer ->
        return (
          Director.make (Scene.create env Game_types.Scene.Base_camp) env renderer
        ) >>= fun d ->
        Lwt_main.run @@ Director.main_loop d |> return
      ) |> ignore
    )
      ~finally:(fun () -> S.Window.destroy window)
  )
