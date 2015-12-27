open Core.Std

module S = Status

type kind = Player [@@deriving sexp]

(* Actor have common status, but not have any specialized behavior related actor's kind. *)
type t = {
  life: S.Life.t;
  status: S.Status.t;
  effects: S.Effect.t list;
  buffs: S.Buff.t list;
  kind: kind;
  id: Uuid.t;
} [@@deriving sexp]

(* Get a empty actor with kind. Actor's identity always generate a new uuid. *)
let empty kind = {
  life = S.Life.empty;
  status = S.Status.empty;
  effects = [];
  buffs = [];
  kind;
  id = Uuid.create ();
}
