type t = {
  inventory: Inventory.t;
  actors: Actor_container.t;
}

let make () = {
  inventory = Inventory.empty;
  actors = Actor_container.empty;
}
