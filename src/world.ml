type gen_types = Obj

type t = {
  generators : (gen_types, Param.Id.gen) Hashtbl.t;
  objects : (Param.Id.t, Param.Base.t) Hashtbl.t;
}

let make () =
  let world = {
    generators = Hashtbl.create 1;
    objects = Hashtbl.create 1;
  } in
  Hashtbl.add world.generators Obj (Param.Id.generator ());
  world

let get_gen ~world ~typ = Hashtbl.find world.generators typ

let get_obj ~world ~id = Hashtbl.find world.objects id

let generate_obj ~world ~generator =
  let gen = get_gen ~world ~typ:Obj in
  let obj = generator gen in
  Hashtbl.add world.objects obj.Param.Base.id obj;
  obj
