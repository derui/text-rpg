open Core.Std
module S = Sdlcaml.Std
module Ttf = Sdlcaml_ttf.Std
module G = Gui_intf

module type Item = sig
  type t

  val select : t -> t
  val name: t -> string
end

module type Item_instance = sig
  module Item: Item
  val this: Item.t
end

let get_text_rect base height index =
  let module R = S.Structures.Rect in
  {base with R.y = base.R.y + index * height; h = height;}

type t = {
  items: (module Item_instance) list;
  rect: S.Structures.Rect.t;
  item_height: int;
  current: int;
  font: Ttf.Type.Font.t;
}

let move_cursor t = function
  | `Up -> begin
    let next = pred t.current in
    if next < 0 then t
    else {t with current = next}
  end
  | `Down -> begin
    let next = succ t.current in
    if List.length t.items <= next then t
    else {t with current = next}
  end

let render t ~renderer =
  let open S.Types.Result.Monad_infix in
  let color = {S.Structures.Color.a = 255;r = 255;g = 255;b = 255} in
  let _ =
    S.Renderer.set_draw_color renderer color >>= fun () ->
    S.Renderer.draw_rect ~renderer ~rect:t.rect >>= fun () ->
    S.Types.Result.return @@ List.iteri t.items ~f:(fun index (module I : Item_instance) ->
      let name = I.Item.name I.this in
      let _ = Ttf.Render.render_utf8_solid ~font:t.font ~text:name ~color >>= fun surface ->
        S.Texture.create_from_surface ~renderer ~surface >>= fun texture ->
        let rect = get_text_rect t.rect t.item_height index in
        S.Renderer.copy ~renderer ~texture ~dst:rect () >>= fun () ->
        S.Surface.free surface >>= fun () ->
        S.Texture.destroy texture
      in ()
    ) in
  Lwt.return_unit

(* Make a new instance of Gui_list module. User must take list of Item_instance to this *)
let make ~items ~rect ~item_height ~font =
  {items = items; rect; item_height; font; current = 0}
