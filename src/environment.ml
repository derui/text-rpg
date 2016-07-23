type t = {
  inventory: Inventory.t;
  player: Character.t;
}

let make () = {
  inventory = Inventory.empty;
}
