
let render ~window ~env current_scene =
  let open Lwt in 
  Lwt_mvar.take current_scene >>= fun (module S : Scene.Scene_instance) ->
  S.Scene_intf.render S.this env window

let () =
  [%sexp_of: Ability.t] {
    Ability.id = 1L;
    ability_class = `Slash_attack;
    value = 0.0;
    mergeability = Ability.Mergeable Ability.Addition
  } |> ignore
