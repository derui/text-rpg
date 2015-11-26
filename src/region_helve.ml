open Core.Std

class t common = object (self)
  inherit Region_base.region common
  method get_region_type = `Helve

  method get_region_uniq_abilities = [`Dexterity; `Agility]
end
