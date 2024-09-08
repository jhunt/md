open Yojson.Basic
open Liquid_ml

let read_json_from file = file |> open_in |> from_channel

let traverse json =
    let rec folder acc (k, v) = acc |> Liquid.Object.add k (converter v)
        and converter v =
          match v with
          | `String s -> Liquid.String s
          | `Bool   b -> Liquid.Bool   b
          | `Int    i -> Liquid.Number (float_of_int i)
          | `Float  f -> Liquid.Number f
          | `List   l -> Liquid.List   (List.map converter l)
          | `Assoc  a -> Liquid.Object (List.fold_left folder Liquid.Object.empty a)
          | `Null     -> Liquid.Nil
          | _         -> Liquid.Nil
    in
    converter (`Assoc (Util.to_assoc json))

let render_template props tpl =
  let obj = traverse (read_json_from props) in
  let context = Liquid.Ctx.empty |> Liquid.Ctx.add "the" obj in
  let settings = Liquid.Settings.make ~context () in
  Liquid.render ~settings tpl

let () = render_template Sys.argv.(1) Sys.argv.(2) |> print_endline
