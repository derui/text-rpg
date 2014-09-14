open Core.Common

(** 内部で利用する統一的なIDを生成する。
    {!generator}で生成されたgeneratorは、個別にIDを生成することができる。ただし、各Idはそれぞれ
    スレッドセーフではないので、複数のスレッドが関連する場合は、排他処理を行う必要がある。
*)
module Id = struct
  type t = int64

  type gen = unit -> t

  let generator ?(init=0L) () =
    let counter = ref init in
    fun () -> let current = !counter in
              counter := Int64.add !counter 1L;
              current
end

(* 変化しないステータスや分類などをまとめる型 *)
module Eigen = struct
  type t = {
    id : Id.t
  }

  let make id = {id}
end

(* 自然数を利用目的に応じた分類のために利用する型 *)
type _life
type _magic
type _speed

module Life = struct
  type value = _life Natural.t
  type t = {
    current : value;
    maximum : value;
  }

  let make initial maximum = {
    current = Natural.make initial;
    maximum = Natural.make maximum;
  }

  let clamp l = {l with current = max (Natural.make 0L) (min l.current l.maximum)}

  let put t current = clamp {t with current}

  let is_valid t = let open Natural.Open in t.current <> (Natural.make 0L)

  let to_string p = Printf.sprintf "%Ld/%Ld" (Natural.to_int64 p.current) (Natural.to_int64 p.maximum)
end
type magic = _magic Natural.t

module Speed = struct
  type t = _speed Natural.t
end

module Physical = struct
  type t = {
    attack: int;
    guard: int;
    speed : Speed.t;
  }

  let empty () = {
    attack = 0;
    guard = 0;
    speed = Natural.make 0L;
  }

end

module Base = struct
  type t = {
    eigen: Eigen.t;
    life : Life.t;
    physical : Physical.t;
    current_turn : Turn.t;
  }

  let empty gen = {
    eigen = Eigen.make (gen ());
    life = Life.make 0L 1L;
    physical = Physical.empty ();
    current_turn = Turn.create ();
  }

  let tick t = {
    t with current_turn = Turn.next_tick t.current_turn t.physical.Physical.speed
  }

end
