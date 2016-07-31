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

let make_fps_timer f =

  let time = ref 0l in
  
  let rec timer f =

    let open Lwt in
    let now = S.Timer.get_ticks () in

    let diff = Int32.(now - !time) in
    if diff >= fps then begin
      time := now;
      f () >>= fun () -> timer f
    end else begin
      let s = Int32.(fps - diff) in
      Lwt_unix.sleep Float.(Int32.to_float s / 1000.0) >>= fun () -> timer f
    end
  in
  fun () -> timer f
    
let () =

  with_sdl (fun () ->
    let module F = S.Flags.Sdl_window_flags in
    let window = S.Window.create ~title:"Text RPG" ~x:0 ~y:0 ~w:640 ~h:480 ~flags:[] in
    protect ~f:(fun () ->

      let env = Environment.make () in
      let current_scene = ref (Scene.create env Game_types.Scene.Base_camp) in

      (* renderer thread with 60 FPS *)
      let rec renderer = make_fps_timer (fun () ->
        render ~window ~env ~current_scene:(!current_scene) ()
      ) in
        
      (* breaker for main loop and renderer thread. *)
      let waiter, wakener = Lwt.wait () in

      let rec event_handler () = 
        let module M = S.Types.Result in
        let module E = S.Structures.Events in
        let module K = S.Structures.Keysym in
        S.Event.pump ();
        let result = M.(S.Event.get () >>= function
          | None -> return Lwt.return_unit
          | Some e -> begin
            let (module S : Scene.Scene_instance) = !current_scene in
            return Lwt.(
              S.Scene.handle_event S.this e >>= fun t ->
              current_scene := (module struct
                module Scene = S.Scene
                let this = t
              end);
              Lwt.return_unit
            )
          end) in
        let t = match result with
          | M.Failure s -> Lwt.fail_with ("In event handler: " ^ s)
          | M.Success t -> t
        in 
        Lwt.(t >>= Lwt_unix.yield >>= event_handler)
      in

      let rec update_scene = make_fps_timer (fun () -> 
        let open Lwt in 
        let (module S : Scene.Scene_instance) = !current_scene in
        catch (fun () -> S.Scene.update S.this env >>= (fun (_, transition) ->
          match transition with
          | Game_types.Scene.Stay -> Lwt.return_unit
          | Game_types.Scene.Transition typ -> begin
            current_scene := Scene.create env typ;
            Lwt.return_unit
          end)
        )
          (function
          | Game_types.Scene.Finished -> Lwt.wakeup wakener () |> Lwt.return
          | _ as e -> Lwt.fail e
          )
      )
      in

      Lwt_main.run @@ Lwt.(renderer () <?> event_handler () <?> update_scene () <?> waiter)
    )
      ~finally:(fun () -> S.Window.destroy window)
  )
