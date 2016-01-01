open Core.Std

type kind =
    Slash_attack | Smash_attack | Lunge_attack
  | Slash_defence | Smash_defence | Lunge_defence
  | Vitality | Dexterity | Agility
  | Life [@@deriving sexp]

