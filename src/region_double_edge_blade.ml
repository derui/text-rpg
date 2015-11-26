open Core.Std

class t common = object (self)
  inherit Region_base.region common
  method get_region_type = `Double_edge_blade

  method get_attachable: Ability.ability_class list =
    let cm = self#get_common in
    List.concat [cm.Region_base.attachable;[`Slash_attack; `Smash_attack]]
end
