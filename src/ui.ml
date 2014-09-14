open Core.Common

type t = {
  status: LTerm_widget.label;
  mutable obj : Object.t;
}

let to_status_text p =
  let module N = Natural in
  let module B = Param_core.Base in
  let module P = Param_core.Physical in
  let module L = Param_core.Life in
  let buf = Buffer.create 10 in
  Buffer.add_string buf (L.to_string p.B.life |> Printf.sprintf "HP : %s\n");
  Buffer.add_string buf (Printf.sprintf "PW : %L\n" p.B.physical.P.attack);
  Buffer.add_string buf (Printf.sprintf "AC : %L\n" p.B.physical.P.guard);
  Buffer.contents buf

let make p =
  let module N = Natural in
  let module B = Param_core.Base in
  let module P = Param_core.Physical in
  let module L = Param_core.Life in
  {
    status = new LTerm_widget.label (to_status_text p.Object.base);
    obj = p;
  }

let layout ui =
  let base = new LTerm_widget.hbox in
  base#add ui.status;
  base

let update ui =
  let module N = Natural in
  let module B = Param_core.Base in
  let module P = Param_core.Physical in
  let module L = Param_core.Life in
  ui.status#set_text (to_status_text ui.obj.Object.base)
