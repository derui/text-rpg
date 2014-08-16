open OUnit

let test_create_generator _ =
  let gen = Param.Id.generator () in
  assert_equal (gen ()) 0L ~msg:"initial value";
  assert_equal (gen ()) 1L ~msg:"closured value"

let test_no_effect_each_generator _ =
  let gen = Param.Id.generator ()
  and gen' = Param.Id.generator () in
  assert_equal (gen ()) 0L;
  assert_equal (gen' ()) 0L

let suite = "Parameter specs" >::: [
  "can create generator" >:: test_create_generator;
  "should not do any side effects each generator" >:: test_no_effect_each_generator;
]
