open Core.Std

class t common = object (self)
  inherit Region_base.region common
  method get_region_type = `Blade
  (* Get type of this region *)

  method get_region_uniq_abilities = [`Slash_attack]
end
