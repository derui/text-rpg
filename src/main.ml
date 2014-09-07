open Core.Common
open CamomileLibrary

let obj_maker generator =
  let module P = Param_core.Base in
  {Object.base = P.empty generator;
   apply_buff = Param_monad.return ()
  }

module Base_layout = struct
  type t = {
    player: Ui.t;
    enemy: Ui.t;
    log : LTerm_widget.label;
  }

  let make world =
    let p = World.generate_obj world  obj_maker
    and e = World.generate_obj world  obj_maker in
    {
    player = Ui.make p;
    enemy = Ui.make e;
    log = new LTerm_widget.label "log";
  }

  let layout l =
    let base = new LTerm_widget.vbox in
    let module G = LTerm_geom in
    base#add (Ui.layout l.player);
    base#add ~expand:false (new LTerm_widget.hline);
    base#add (Ui.layout l.enemy);
    base#add ~expand:false (new LTerm_widget.hline);
    base#add l.log;
    base

  let update t =
    Ui.update t.player;
    Ui.update t.enemy

end

let make_handler base wakener current =
  Event_handler.make (function
  | Event_handler.Attack (from', to') -> begin
    let module O = Object in
    let _ , e = Attack.attack from' to' in
    if !current then
      base.Base_layout.enemy.Ui.obj <- e
    else
      base.Base_layout.player.Ui.obj <- e;

    Base_layout.update base;

    let module B = Param_core.Base in
    let module L = Param_core.Life in
    let open Natural.Open in
    if e.Object.base.B.life.L.current = (Natural.make 0L) then
      Some (Event_handler.End)
    else
      Some(Event_handler.Continue)
  end
  | Event_handler.End -> Lwt.wakeup wakener (); None
  | _ -> None
  )

let () =
  let stdin = Lwt_unix.of_unix_file_descr Unix.stdin
  and stdout = Lwt_unix.of_unix_file_descr Unix.stdout in
  let window = LTerm.create stdin Lwt_io.stdin stdout Lwt_io.stdout in
  let world = World.make () in

  Random.init 4;
  begin
    let open Lwt in
    Lwt_main.run (
      window >>= fun window ->
      LTerm.enter_raw_mode window >>= fun mode ->

      let waiter, wakener = wait () in
      let base = Base_layout.make world in
      let boxes = Base_layout.layout base in

      let current = ref true in
      let handler = make_handler base wakener current in

      boxes#on_event (function
      | LTerm_event.Key(key) -> begin
        match key.LTerm_key.code with
        | LTerm_key.Char (c) -> begin
          match UChar.char_of c with
          | 'q' -> wakeup wakener (); true
          | 'z' -> boxes#add (new LTerm_widget.label "click"); true
          | 'a' ->
             let p = base.Base_layout.player
             and e = base.Base_layout.enemy in
             if !current then begin
               Event_handler.send handler (Event_handler.Attack (p.Ui.obj, e.Ui.obj))
             end else begin
               Event_handler.send handler (Event_handler.Attack (e.Ui.obj, p.Ui.obj))
             end;
             current := not !current;
             true
          | _ -> false
        end
        | _ -> false
      end
      | _ -> false);

      LTerm_widget.run window ~resources_file:"./.lambdarc" boxes waiter >>= fun () ->
      LTerm.leave_raw_mode window mode
    )

  end
