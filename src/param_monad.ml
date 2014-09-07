open Core.Common
module B = Param_core.Base

module Basic = struct
  type 'a state = 'a * Param_core.Base.t
  type 'a t = Param_core.Base.t -> 'a state

  let return x s = (x, s)

  let run_state (t:'a t) (s:Param_core.Base.t) = t s
  let eval_state t s = snd (run_state t s)
  let bind p f s = let (nv, ns) = run_state p s in
                   let act = f nv in
                   run_state act ns

  let map = `Define_using_bind
end

module M = Core.Monad.Make(Basic)
include Basic
include M

(* get and put Physical in the state of Param_core.Base *)
let get_physical () s = (s.Param_core.Base.physical, s)
let put_physical p s = ((), {s with Param_core.Base.physical = p})

let modify_physical f s =
  let p = s.B.physical in ((), {s with B.physical = f p})

(* get Life in the state of Param_core.Base *)
let get_life () s = (s.B.life, s)
