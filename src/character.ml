open Core.Std

(* type of result when done action *)
type result = Actor.t * Message.t option

(* basement character object. All specialized characters has to implement do_action and handle_message
   methods.
*)
module type Character = sig
  type t

  val actor_id: t -> Actor_id.t
  (* Return id of actor to be related this *)

  val do_action: t -> Actor.t -> result
  (* Update status in actor and return a message if action *)

  val handle_message: t -> Actor.t -> Message.t -> result
  (* A handler to handle message given from other actor *)
end

(* Interface for instance of a character. *)
module type Character_instance = sig
  module Character : Character
  val this : Character.t
end
