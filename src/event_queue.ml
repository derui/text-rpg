type t = {
  queue : Param.Base.t Queue.t
}

let make () = {
  queue = Queue.create ()
}
