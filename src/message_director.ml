open Core.Std

type messages = Message.t Squeue.t

type t = {
  (* messages to send an actor. *)
  messages: messages;
}
