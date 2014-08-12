type t = {
  hp: LTerm_widget.label;
  attack: LTerm_widget.label;
  guard: LTerm_widget.label;
  mutable param : Param.Base.t;
}

let make p =
  let module P = Param.Base in
  {
    hp = new LTerm_widget.label (string_of_int p.P.hp);
    attack = new LTerm_widget.label (string_of_int p.P.attack);
    guard = new LTerm_widget.label (string_of_int p.P.guard);
    param = p;
  }

let layout ui =
  let base = new LTerm_widget.hbox in
  base#add ui.hp;
  base#add ui.attack;
  base#add ui.guard;
  base

let update ui =
  let module P = Param.Base in
  begin
    ui.hp#set_text (string_of_int ui.param.P.hp);
    ui.attack#set_text (string_of_int ui.param.P.attack);
    ui.guard#set_text (string_of_int ui.param.P.guard);
  end
