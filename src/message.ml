(* defind messages in this system *)
open Core.Std

type message = [
  (* Attack from sender to receiver *)
  `Attack of Float.t
]

type t = {
  receiver: Actor.t;
  sender: Actor.t;
  message: message;
}

