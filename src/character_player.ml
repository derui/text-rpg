(* Character implementation for Player *)

type t = {
  actor: Actor.t
}
let get_actor t = t.actor
let update t actor = (actor, None)
let handle_message t actor mes = (actor, None)

let make actor = {
  actor
}
