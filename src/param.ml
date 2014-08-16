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

module Base = struct
  type t = {
    id : Id.t;
    hp: int;
    attack: int;
    guard: int;
  }

  let empty gen = {
    id = gen ();
    hp = 0;
    attack = 0;
    guard = 0;
  }

  let to_string t = Printf.printf "(hp=%d attack=%d guard=%d)" t.hp t.attack t.guard

end
