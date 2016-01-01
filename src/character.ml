open Core.Std

(* type of result when done action *)
type result = Actor.t * Message.t option

(* basement character object. All specialized characters has to implement do_action and handle_message
   methods.
*)
class virtual t (id: Actor.Id.t) = object (self)
  (* Return id of actor to be related this *)
  method actor_id = id

  (* Update status in actor and return a message if action *)
  method virtual do_action: Actor.t -> result

  (* A handler to handle message given from other actor *)
  method virtual handle_message: Actor.t -> Message.t -> result
end
