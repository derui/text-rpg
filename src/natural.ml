open Core.Common

  (* 自然数を扱うためのモジュール。phantom typeを用いて、同じphantom typeについてのみ計算することができる。 *)
type 'a t = int64

let make (nat: int64) = nat
let add (t:'a t) (t':'a t) = max (Int64.add t t') 0L
let sub (t:'a t) (t':'a t) = max (Int64.sub t t') 0L
let mul (t:'a t) (t':'a t) = max (Int64.mul t t') 0L
let div (t:'a t) (t':'a t) = max (Int64.div t t') 0L
let compare (t: 'a t) (t': 'a t) = Int64.compare t t'
let of_int : int -> 'a t = Int64.of_int
let to_int : 'a t -> int = Int64.to_int
let to_int64 (v : 'a t) = (v : int64)
let to_string : 'a t -> string = Int64.to_string

module Open = struct
  let (+) t t' = add t t'
  let (-) t t' = sub t t'
  let ( * ) t t' = mul t t'
  let (/) t t' = div t t'
  let (<) t t' = compare t t' = 1
  let (>) t t' = compare t t' = (-1)
  let (>=) t t' = not (t < t')
  let (<=) t t' = not (t > t')
end
