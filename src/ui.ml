open Core.Common

type t = {
  hp: LTerm_widget.label;
  attack: LTerm_widget.label;
  guard: LTerm_widget.label;
  mutable obj : Object.t;
}

let make p =
  {
    hp = new LTerm_widget.label "";
    attack = new LTerm_widget.label "";
    guard = new LTerm_widget.label "";
    obj = p;
  }

let layout ui =
  let base = new LTerm_widget.hbox in
  base#add ui.hp;
  base#add ui.attack;
  base#add ui.guard;
  base

let update ui =
  let module P = Param_core.Base in
  begin
    ui.hp#set_text "";
    ui.attack#set_text "";
    ui.guard#set_text "";
  end
