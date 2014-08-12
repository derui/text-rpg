open CamomileLibrary

module Player = struct
  let make () =
    let module P = Param.Base in
    let param = {
      P.hp = (Random.int 20) + 10;
      P.attack = (Random.int 20) + 10;
      P.guard = (Random.int 20) + 10;
    } in
    Ui.make param
end

module Enemy = struct
  let make () =
    let module P = Param.Base in
    let param = {
      P.hp = (Random.int 20) + 10;
      P.attack = (Random.int 20) + 10;
      P.guard = (Random.int 20) + 10;
    } in
    Ui.make param
end

module Base_layout = struct
  type t = {
    player: Ui.t;
    enemy: Ui.t;
    log : LTerm_widget.label;
  }

  let make () = {
    player = Player.make ();
    enemy = Enemy.make ();
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

let make_handler base wakener =
  Event_handler.make (function
  | Event_handler.Attack (from', to') -> begin
    let _ , e = Attack.attack from' to' in
    base.Base_layout.enemy.Ui.param <- e;
    Base_layout.update base;

    if e.Param.Base.hp = 0 then
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

  Random.init 4;
  begin
    let open Lwt in
    Lwt_main.run (
      window >>= fun window ->
      LTerm.enter_raw_mode window >>= fun mode ->

      let waiter, wakener = wait () in
      let base = Base_layout.make () in
      let boxes = Base_layout.layout base in

      let handler = make_handler base wakener in

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
            Event_handler.send handler (Event_handler.Attack (p.Ui.param, e.Ui.param));
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
