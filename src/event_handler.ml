open Core.Common

type event =
  Attack of Object.t * Object.t                       (* 攻撃を行う *)
| Continue                      (* まだ継続する *)
| End                           (* 終了する *)

type handler = event -> event option

type t = {
  handler : handler;
}

let make handler = {handler}

let send handler event =
  let rec _handler event =
    match handler.handler event with
    | None -> ()
    | Some (e) -> _handler e
  in
  _handler event
