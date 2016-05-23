[%%suite
 open Core.Std
 module S = Status

 let%spec "Buff pass over a turn with function manipulate weight" =
   let buff = S.Buff.make ~element:(S.Element.make ~kind:S.Vitality ~quantity:1.0)
     ~weight:1.5
     ~duration:10
   in
   let buff = S.Buff.pass_turn buff () in
   S.Buff.is_finished buff [@eq false];
   let buff = S.Buff.pass_turn buff ~f:(fun ~weight ~duration -> weight -. 0.5) () in
   S.Buff.weight buff [@eq 1.0]

 let%spec "Buff can return it finished or not" =
   let buff = S.Buff.make ~element:(S.Element.make ~kind:S.Vitality ~quantity:1.0)
     ~weight:1.5
     ~duration:1
   in
   S.Buff.is_finished buff [@false];

   let buff = S.Buff.pass_turn buff () in
   S.Buff.is_finished buff [@true]

 let%spec "Basement can update specified element" =
   let open S in
   let base = Base.empty in
   let element = Element.make ~kind:Slash_attack ~quantity:1.0 in
   let base = Base.update base element in
   Base.get_element base Slash_attack [@eq Some element];
   Base.get_element base Life [@eq None]

]
