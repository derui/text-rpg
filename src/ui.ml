open Core.Common

type t = {
  hp: LTerm_widget.label;
  attack: LTerm_widget.label;
  guard: LTerm_widget.label;
  mutable obj : Object.t;
}

let make p =
  let module N = Natural in
  let module B = Param_core.Base in
  let module P = Param_core.Physical in
  let module L = Param_core.Life in
  {
    hp = new LTerm_widget.label (N.to_string p.Object.base.B.life.L.current);
    attack = new LTerm_widget.label (string_of_int p.Object.base.B.physical.P.attack);
    guard = new LTerm_widget.label (string_of_int p.Object.base.B.physical.P.guard);
    obj = p;
  }

let layout ui =
  let base = new LTerm_widget.hbox in
  base#add ui.hp;
  base#add ui.attack;
  base#add ui.guard;
  base

let update ui =
  let module N = Natural in
  let module B = Param_core.Base in
  let module P = Param_core.Physical in
  let module L = Param_core.Life in
  begin
    ui.hp#set_text (N.to_string ui.obj.Object.base.B.life.L.current);
    ui.attack#set_text (string_of_int ui.obj.Object.base.B.physical.P.attack);
    ui.guard#set_text (string_of_int ui.obj.Object.base.B.physical.P.guard);
  end
