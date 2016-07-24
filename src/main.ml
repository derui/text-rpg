module S = Sdlcaml.Std
open Core.Std

let previous_time = ref 0l
let fps = Int32.(1000l / 60l)

let render ~window ~env ~current_scene () =
  let open Lwt in 
  Lwt_mvar.take current_scene >>= fun (module S : Scene.Scene_instance) ->
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
      let current_scene = Lwt_mvar.create (Scene.create env Game_types.Scene.Base_camp) in
      previous_time := S.Timer.get_ticks ();

      (* renderer thread with 60 FPS *)
      let rec renderer () =
        let open Lwt in
        let now = S.Timer.get_ticks () in

        let diff = Int32.(now - !previous_time) in
        if diff > fps then
          render ~window ~env ~current_scene ()
        else
          S.Timer.delay Int32.(fps - diff) |> renderer
      in
      (* breaker for main loop and renderer thread. *)
      let waiter, wakener = Lwt.wait () in

      (* Main loop. This loop has all logic without for scene rendering *)
      let event_loop () =
        let open Lwt in
        let rec inner_loop () = 
          return (S.Event.waiting ignore) >>= fun _ -> inner_loop ()
        in

        renderer () <?> inner_loop ()
      in

      Lwt_main.run (Lwt.join [event_loop (); waiter]) |> ignore;
    )
      ~finally:(fun () -> S.Window.destroy window)
  )
