open Core.Std

type kind = Player [@@deriving sexp]

(* Actor have common status, but not have any specialized behavior related actor's kind. *)
type t [@@deriving sexp]

val empty: (module Actor_id.Generator_instance) -> kind -> t
(* Get a empty actor with kind. Actor's identity always generate a new uuid. *)

val id: t -> Actor_id.t
(* [id actor] gets the identifier of the actor *)

val kind: t -> kind
(* [kind actor] gets the kind of the actor *)
