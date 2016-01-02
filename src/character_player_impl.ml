(* Character implementation for Player *)

class t (id: Actor.Id.t) = object (self)
  inherit Character.t(id)
  method do_action actor = (actor, None)
  method handle_message actor mes = (actor, None)
end
