open Core.Std

module Inventory = Map.Make(Int64)

type t = {
  regions: Region_base.t Inventory.t;
  (* the inventory for regions *)
  abilities: Ability.t Inventory.t;
  (* the inventory for regions *)
  weapons: Weapon_base.t Inventory.t;
(* the inventory for weapons *)
}

let empty = {
  regions = Inventory.empty;
  abilities = Inventory.empty;
  weapons = Inventory.empty;
}

(* add a region into the inventory *)
let add_region t region =
  let module R = Region_base in
  {t with regions = Inventory.add t.regions ~key:(R.region_id region) ~data:region}

(* add an ability into the inventory *)
let add_ability t ability =
  let module A = Ability in
  {t with abilities = Inventory.add t.abilities ~key:(ability.A.id) ~data:ability}

(* add an ability into the inventory *)
let add_weapon t weapon =
  let module W = Weapon_base in
  {t with weapons = Inventory.add t.weapons ~key:(weapon.W.id) ~data:weapon}

(* find an item from the inventory *)
let find_region t r = Inventory.find t.regions (Region_base.region_id r)
let find_ability t a = Inventory.find t.abilities a.Ability.id 
let find_weapon t w = Inventory.find t.weapons w.Weapon_base.id

(* remove an item from the inventory *)
let remove_region t r = {t with regions = Inventory.remove t.regions (Region_base.region_id r)}
let remove_ability t a = {t with abilities = Inventory.remove t.abilities a.Ability.id}
let remove_weapon t w = {t with weapons = Inventory.remove t.weapons w.Weapon_base.id}
