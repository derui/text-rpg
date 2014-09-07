type 'a t
val make : int64 -> 'a t
val add : 'a t -> 'a t -> int64
val sub : 'a t -> 'a t -> int64
val mul : 'a t -> 'a t -> int64
val div : 'a t -> 'a t -> int64
val compare : 'a t -> 'a t -> int
val of_int : int -> 'a t
val to_int : 'a t -> int
val to_int64 : ('a t -> int64) -> 'a t -> int64
val to_string : 'a t -> string
module Open :
  sig
    val ( + ) : 'a t -> 'a t -> 'a t
    val ( - ) : 'a t -> 'a t -> 'a t
    val ( * ) : 'a t -> 'a t -> 'a t
    val ( / ) : 'a t -> 'a t -> 'a t
    val ( < ) : 'a t -> 'a t -> bool
    val ( > ) : 'a t -> 'a t -> bool
    val ( >= ) : 'a t -> 'a t -> bool
    val ( <= ) : 'a t -> 'a t -> bool
  end
