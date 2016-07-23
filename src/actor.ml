open Core.Std

module S = Status

type kind = Player [@@deriving sexp]

(* Actor have common status, but not have any specialized behavior related actor's kind. *)
type t = {
  life: S.Life.t;
  base: S.Base.t;
  effects: S.Effect.t list;
  buffs: S.Buff.t list;
  kind: kind;
  id: Actor_id.t;
} [@@deriving sexp]

(* Get a empty actor with kind. Actor's identity always generate a new uuid. *)
let empty (module G : Actor_id.Generator_instance) kind = {
  life = S.Life.empty;
  base = S.Base.empty;
  effects = [];
  buffs = [];
  kind;
  id = G.Generator.gen G.this ();
}

let id {id;_} = id
let kind {kind;_} = kind
