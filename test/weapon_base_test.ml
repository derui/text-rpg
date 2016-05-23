[%%suite
 open Core.Std
 module R = Region_base

 let builtin = {
   R.Builtin.unique_ability = `Slash_attack;
   attachable = [];
   region_type = `Blade
 }

 let%spec "Weapon can detach region having self" =
   let module A = Ability in
   let module W = Weapon_base in
   let module C = Region_common in
   let regions = [R.make ~builtin ~common:{
     R.Common.id = 1L;
     base_ratio = 0.1;
     max_abilities = 1;
     abilities = [{
       A.id = 1L;
       ability_class = `Slash_attack;
       value = 1.0;
       mergeability = A.Unmergeable
     }];
   }] in
   let w = W.make ~id:1L ~regions ~components:[] () in

   let region, w = W.detach_region w 1L in
   region [@eq Some (List.nth_exn regions 0)];
   List.length w.W.regions [@eq 0]


 let%spec "Weapon can detach region not contained and get None as region" =
   let module A = Ability in
   let module W = Weapon_base in
   let module C = Region_common in
   let regions = [R.make ~builtin ~common:{
     R.Common.id = 1L;
     base_ratio = 0.1;
     max_abilities = 1;
     abilities = [{
       A.id = 1L;
       ability_class = `Slash_attack;
       value = 1.0;
       mergeability = A.Unmergeable
     }];
   }] in
   let w = W.make ~id:1L ~regions ~components:[] () in

   let region, w = W.detach_region w 2L in
   region [@eq None];
   List.length w.W.regions [@eq 1]

]
