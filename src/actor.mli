open Core.Std

(* A module for actor identifier *)
module Id: sig
  type t [@@deriving sexp]

  val compare: t -> t -> int
end

type kind = Player [@@deriving sexp]

(* Actor have common status, but not have any specialized behavior related actor's kind. *)
type t [@@deriving sexp]

val empty: kind -> t
(* Get a empty actor with kind. Actor's identity always generate a new uuid. *)

val id: t -> Id.t
(* [id actor] gets the identifier of the actor *)

val kind: t -> kind
(* [kind actor] gets the kind of the actor *)
