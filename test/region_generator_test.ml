[%%suite
 open Core.Std
 module R = Region_base

 let builtin_blade = {
   R.Builtin.unique_ability = `Slash_attack;
   attachable = [`Slash_attack;`Slash_defence];
   region_type = `Blade
 }

 let builtin_helve = {
   R.Builtin.unique_ability = `Slash_defence;
   attachable = [`Slash_attack;`Slash_defence];
   region_type = `Helve
 }

 let%spec "Region generator can generate an region via given State" =
   let state = Random.State.make [||] in
   let module A = Ability_generator in
   let module AS = Ability_setting in
   let ability_generator = A.make ~state ~setting:{
     AS.mergeable_abilities = [`Slash_attack];
     unmergeable_abilities = [`Slash_defence]
   } in
   let module S = Region_setting in
   let gen = Region_generator.make ~state ~ability_generator ~setting:{
     S.region_builtins = [(`Blade, builtin_blade);(`Helve, builtin_helve)];
     max_attachable_count = 2;
     region_attachable_freq = [(`Blade, [(1.0, `Slash_attack)]);
                               (`Helve, [(1.0, `Slash_defence)])]
   } in

   let reg = Region_generator.new_region gen in
  (* This assert always equal, because no change random state seed always. *)
   reg.R.builtin [@eq builtin_blade];
   reg.R.common.R.Common.base_ratio [@eq 0.5];
   reg.R.common.R.Common.max_abilities [@eq 1];
   List.length reg.R.common.R.Common.abilities [@eq 1];
  (* Contained ability is always slash_attack because per-region ability frequency
     only one ability class
  *)
   let ability = List.nth_exn reg.R.common.R.Common.abilities 0 in
   ability.Ability.ability_class [@eq `Slash_attack]

]
