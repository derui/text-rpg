open Core.Std

type t = Uuid.t [@@deriving sexp]
(* A type of Identifier for Actor *)

let compare = Uuid.compare
(* Function to compare each identifier *)

(* Identifier generator interface *)
module type Generator = sig
  type generator
  val gen : generator -> unit -> t
end

(* Identifier generator instance interface. This interface should contain the environment *)
module type Generator_instance = sig
  module Generator : Generator
  val this : Generator.generator
end

(* Default identifier generator. *)
module Default_generator = struct
  module Generator = struct
    type generator = unit
    let gen () = Uuid.create
  end

  let this = ()
end
