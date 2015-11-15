open Core.Std

class t common = object (self)
  inherit Region_base.region common
  method get_region_type = `Lower_guard

  method get_attachable: Ability.ability_class list =
    let cm = self#get_common in
    List.concat [cm.Region_base.attachable;[`Slash_defence; `Smash_defence]]
end
