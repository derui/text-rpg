open Core.Std

class t common = object (self)
  inherit Region_base.region common
  method get_region_type = `Broad_blade

  method get_region_uniq_abilities = [`Slash_attack; `Smash_attack]
end
