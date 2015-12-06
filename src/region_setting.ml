open Core.Std
module R = Region_base

type builtin = R.region_type * R.Builtin.t [@@deriving sexp]
(* Builtin with region_type to map on a list *)
type frequency = Float.t * Ability.ability_class
  [@@deriving sexp]
(* Frequency is a ability attachable frequency. All frequency must less equal than 1.0 *)
type region_freq = R.region_type * frequency list [@@deriving sexp]
(* Per-region ability frequency list. Sum of frequency in this type must equal to 1.0 *)

type t = {
  region_builtins: builtin list;
  (* A list of mergeable ability *)
  max_attachable_count: Int.t;
(* Maximum count to be able to attach a region *)
  region_attachable_freq: region_freq list
(* Per-region frequency attached ability. Each freqency for re *)
} [@@deriving sexp]

let empty = {
  region_builtins = [];
  max_attachable_count = 0;
  region_attachable_freq = []
}

let save setting file =
  Out_channel.with_file file ~f:(fun f ->
    ([%sexp_of:t] setting) |> Sexp.to_string |> Out_channel.output_string f 
  )

let load file =
  match Sys.file_exists file with
  | `Yes -> begin
    In_channel.with_file file ~f:(fun f ->
      Sexp.input_sexp f |> [%of_sexp:t]
    ) |> Option.some
  end
  | _ -> None
