type result = Param.Base.t * Param.Base.t

let attack from_param to_param =
  let module P = Param.Base in
  let damage = from_param.P.attack - to_param.P.guard in
  let damage = max damage 0 in
  if to_param.P.hp < damage then
    (from_param, {to_param with P.hp = 0})
  else
    (from_param, {to_param with P.hp = to_param.P.hp - damage})
