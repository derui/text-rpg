type t = {
  base : Param_core.Base.t;
  apply_buff : unit Param_monad.t;
}

module C = Param_core

let id t = t.base.C.Base.eigen.C.Eigen.id

let apply {base; apply_buff} = Param_monad.evalState apply_buff base
