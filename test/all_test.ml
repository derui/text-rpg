open OUnit

let suite  = "All tests" >::: [
  Event_queue_test.suite;
  Param_test.suite;
]

let () =
  ignore (run_test_tt_main suite);
