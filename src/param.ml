module Base = struct
  type t = {
    hp: int;
    attack: int;
    guard: int;
  }

  let empty () = {
    hp = 0;
    attack = 0;
    guard = 0;
  }

  let to_string t = Printf.printf "(hp=%d attack=%d guard=%d)" t.hp t.attack t.guard

end
