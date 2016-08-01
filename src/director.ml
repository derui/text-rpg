module S = Sdlcaml.Std
open Core.Std

(** Core game engine. Director has render, update, and event handler mechanicses.
    Some side-effects without state of game such as actor, charactors.
*)

type t = {
  mutable current_scene: (module Scene.Scene_instance);
  mutable environment: Environment.t;
  renderer: S.Renderer.t;
  waiter: unit Lwt.t;
  wakener: unit Lwt.u;
}

let make scene env renderer =
  let waiter, wakener = Lwt.wait () in
  {
    current_scene = scene;
    environment = env;
    renderer;
    waiter;
    wakener;
  }

let fps = Int32.(1000l / 32l)

(* Create repeatable function that execute each frame defined by FPS *)
let make_fps_timer fps f =

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

let render ~renderer ~env ~current_scene () =
  let open Lwt in 
  let (module S : Scene.Scene_instance) = current_scene in
  S.Scene.render S.this env renderer

(* renderer thread with 60 FPS *)
let renderer director = make_fps_timer fps (fun () ->
  let {renderer; current_scene;environment = env;_} = director in
  render ~renderer ~env ~current_scene ()
)

let rec event_handler director () = 
  let module M = S.Types.Result in
  let module E = S.Structures.Events in
  let module K = S.Structures.Keysym in
  S.Event.pump ();
  let result = M.(S.Event.get () >>= function
    | None -> return Lwt.return_unit
    | Some e -> begin
      let (module S : Scene.Scene_instance) = director.current_scene in
      return Lwt.(
        S.Scene.handle_event S.this e >>= fun t ->
        director.current_scene <- (module struct
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
  Lwt.(t >>= Lwt_unix.yield >>= event_handler director)

let update_scene director = make_fps_timer fps (fun () -> 
  let open Lwt in 
  let (module S : Scene.Scene_instance) = director.current_scene in
  let env = director.environment in
  catch (fun () -> S.Scene.update S.this env >>= (fun (_, transition) ->
    match transition with
    | Game_types.Scene.Stay -> Lwt.return_unit
    | Game_types.Scene.Transition typ -> begin
      director.current_scene <- Scene.create env typ;
      Lwt.return_unit
    end)
  )
    (function
    | Game_types.Scene.Finished -> Lwt.wakeup director.wakener () |> Lwt.return
    | _ as e -> Lwt.fail e
    )
)

let main_loop director =

  Lwt.(renderer director () <?> event_handler director () <?>
         update_scene director () <?> director.waiter)
