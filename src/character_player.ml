(* Character implementation for Player *)

type t = {
  id: Actor_id.t
}
let actor_id t = t.id
let do_action t actor = (actor, None)
let handle_message t actor mes = (actor, None)

let make id = {
  id
}
