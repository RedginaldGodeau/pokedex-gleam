import controller/controller
import core/context
import gleam/http/request
import gleam/string_tree
import wisp

pub fn init_route(req: wisp.Request, ctx: context.Context) -> wisp.Response {
  case request.path_segments(req) {
    [] -> controller.hello_world(req, ctx)
    ["id", id] -> controller.get_pokemon_by_id(req, ctx, id)
    ["name", name] -> controller.get_pokemon_by_name(req, ctx, name)
    _ -> wisp.json_response(string_tree.from_string("Not Found"), 404)
  }
}
