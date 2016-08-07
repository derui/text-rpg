module S = Sdlcaml.Std
module Ttf = Sdlcaml_ttf.Std

(* A rendering context that is context to render scene. *)
type t = {
  renderer: S.Renderer.t;
  font: Ttf.Type.Font.t;
}

let make ~renderer ~font =
  {renderer; font}
