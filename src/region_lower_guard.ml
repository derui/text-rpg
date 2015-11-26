open Core.Std

class t common = object (self)
  inherit Region_base.region common
  method get_region_type = `Lower_guard

  method get_region_uniq_abilities = [`Slash_defence; `Smash_defence]
end
