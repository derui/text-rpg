open Core.Std
module R = Region_base

type builtin = R.region_type * R.Builtin.t [@@deriving sexp]

type t = {
  region_builtins: builtin list
  (* A list of mergeable ability *)
} [@@deriving sexp]

let empty = {region_builtins = []}

let save setting file =
  Out_channel.with_file file ~f:(fun f ->
    let builtins = List.map setting.region_builtins ~f:Tuple.T2.get2 in
    ([%sexp_of:R.Builtin.t list] builtins) |> Sexp.to_string |> Out_channel.output_string f 
  )

let load file =
  match Sys.file_exists file with
  | `Yes -> begin
    let list = In_channel.with_file file ~f:(fun f ->
      Sexp.input_sexp f |> [%of_sexp:R.Builtin.t list]
    ) in
    let list = List.map list ~f:(fun b -> (b.R.Builtin.region_type, b)) in
    Some ({region_builtins = list})
  end
  | _ -> None
