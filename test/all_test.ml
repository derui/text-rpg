open OUnit

let suite  = "All tests" >::: [
  Param_test.suite;
  Turn_test.suite;
]

let () =
  ignore (run_test_tt_main suite);
