open Core.Std

type ability_class = [
    `Slash_attack | `Slash_defence | `Smash_attack | `Smash_defence
  | `Dexterity | `Agility
]
  [@@deriving sexp]

(* Type of merge between each abilities. *)
type merge_type = Addition | Multiplication [@@deriving sexp]

(* The mergeablity for ability *)
type mergeable = Mergeable of merge_type | Unmergeable
  [@@deriving sexp]

(* Type of ability *)
type t = {
  ability_class:ability_class;
  value: Float.t;
  mergeable: mergeable;
} [@@deriving sexp]

(* Offset for an ability. Offset is merged each abilities with merge_type. *)
type offset = {
  amount_addition: Float.t;
  amount_multiple: Float.t;
  amount_unmergeable: Float.t option;
}

let abilities_to_offset ~target_class abilities =
  let module M = Map.Make(struct
      type t = merge_type
      let t_of_sexp = [%of_sexp : merge_type]
      let sexp_of_t = [%sexp_of : merge_type]
      let compare = Pervasives.compare
    end) in

  (* Predicate an ability mergeable or not *)
  let is_mergeable = function
    | {mergeable = Mergeable _;_} -> true
    | _ -> false
  in

  (* Merge ability value based on ability mergeablility. *)
  let rec to_mergeable_offset hashmap = function
    | [] -> hashmap
    | (ab, Mergeable typ) :: rest -> begin
        match M.find hashmap typ with
        | None -> to_mergeable_offset (M.add hashmap ~key:typ ~data:ab.value) rest
        | Some v -> 
          to_mergeable_offset (M.add hashmap ~key:typ ~data:(v +. ab.value)) rest
      end
    | _ :: rest -> to_mergeable_offset hashmap rest
  in

  (* Get the maximum unmergeable value in [abilities]. *)
  let rec to_unmergeable_offset v = function
    | [] -> v
    | ab :: rest -> match v with
      | None -> to_unmergeable_offset (Some ab.value) rest
      | Some v -> to_unmergeable_offset (Some (max ab.value v)) rest
  in

  let mergeables = List.filter_map ~f:(fun v ->
      if is_mergeable v then Some (v, v.mergeable) else None
    ) abilities in
  let unmergeables = List.filter ~f:(Fn.non is_mergeable) abilities in

  let mergeables = to_mergeable_offset M.empty mergeables in
  let unmergeables = to_unmergeable_offset None unmergeables in

  {
    amount_addition = M.find mergeables Addition |> Option.value ~default:0.0;
    amount_multiple = M.find mergeables Multiplication |> Option.value ~default:1.0;
    amount_unmergeable = unmergeables;
  }
