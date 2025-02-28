import controller/controller
import core/context
import gleam/http/request
import gleam/string_tree
import wisp

pub fn init_route(req: wisp.Request, ctx: context.Context) -> wisp.Response {
  case request.path_segments(req) {
    [] -> controller.home_page(req, ctx)
    ["pokemon", id] -> controller.pokemon_page(req, ctx, id)
    ["all"] -> controller.get_all_pokemon(req, ctx)
    ["id", id] -> controller.get_pokemon_by_id(req, ctx, id)
    ["name", name] -> controller.get_pokemon_by_name(req, ctx, name)
    ["search", search] -> controller.get_pokemon_by_search(req, ctx, search)

    _ -> wisp.json_response(string_tree.from_string("Not Found"), 404)
  }
}
