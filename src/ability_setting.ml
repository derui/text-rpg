open Core.Std

type t = {
  mergeable_abilities: Ability.ability_class list;
  (* A list of mergeable ability *)

  unmergeable_abilities: Ability.ability_class list;
  (* A list of mergeable ability *)
} [@@deriving sexp]

let save setting file =
  Out_channel.with_file file ~f:(fun f ->
    ([%sexp_of:t] setting) |> Sexp.to_string |> Out_channel.output_string f 
  )

let load file =
  In_channel.with_file file ~f:(fun f ->
    Sexp.input_sexp f |> [%of_sexp:t]
  )
