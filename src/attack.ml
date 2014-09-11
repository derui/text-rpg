open Core.Common

let attack from_obj to_obj =
  let module B = Param_core.Base in
  let module P = Param_core.Physical in
  let module L = Param_core.Life in
  let from_p = Object.apply from_obj
  and to_p = Object.apply to_obj in
  let damage = from_p.B.physical.P.attack - to_p.B.physical.P.guard in
  let damage = max 0 damage in
  let life = to_p.B.life in
  let open Natural.Open in
  let life = life.L.current - (Natural.of_int damage) in
  (from_obj, {to_obj with Object.base = {to_p with B.life = L.put to_p.B.life life}})
