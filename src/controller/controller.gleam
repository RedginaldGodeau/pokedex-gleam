import app/page
import app/page/layout
import core/context
import gleam/int
import gleam/io
import lustre/element

import gleam/json

import model/pokemon
import wisp

pub fn middleware(
  req: wisp.Request,
  ctx: context.Context,
  handle_request: fn(wisp.Request) -> wisp.Response,
) -> wisp.Response {
  let req = wisp.method_override(req)
  use <- wisp.log_request(req)
  use <- wisp.rescue_crashes
  use req <- wisp.handle_head(req)
  use <- wisp.serve_static(req, under: "/static", from: ctx.static_directory)
  handle_request(req)
}

pub fn home_page(req: wisp.Request, ctx: context.Context) -> wisp.Response {
  use _req <- middleware(req, ctx)
  let assert Ok(pokemons) = pokemon.get_all(ctx.db)
  [page.home_page(pokemons)]
  |> layout.layout("Hello World")
  |> element.to_document_string_builder
  |> wisp.html_response(200)
}

pub fn pokemon_page(
  req: wisp.Request,
  ctx: context.Context,
  id: String,
) -> wisp.Response {
  use _req <- middleware(req, ctx)
  let assert Ok(id_int) = int.parse(id)
  let assert Ok(poke) = pokemon.get_by_id(id_int, ctx.db)
  [page.pokemon_page(poke)]
  |> layout.layout("Hello World")
  |> element.to_document_string_builder
  |> wisp.html_response(200)
}

pub fn get_pokemon_by_id(
  req: wisp.Request,
  ctx: context.Context,
  id: String,
) -> wisp.Response {
  use _req <- middleware(req, ctx)

  let assert Ok(id_int) = int.parse(id)
  let result = {
    case pokemon.get_by_id(id_int, ctx.db) {
      Ok(pkmon) -> {
        let object =
          json.object([
            #("id", json.int(pkmon.id)),
            #("name", json.string(pkmon.name)),
            #("type_1", json.string(pkmon.type_1)),
            #("type_2", json.string(pkmon.type_2)),
            #("total", json.int(pkmon.total)),
            #("attack", json.int(pkmon.attack)),
            #("defense", json.int(pkmon.defense)),
            #("sp_attack", json.int(pkmon.sp_attack)),
            #("sp_defense", json.int(pkmon.sp_defense)),
            #("speed", json.int(pkmon.speed)),
            #("generation", json.int(pkmon.generation)),
            #("legendary", json.bool(pkmon.legendary)),
          ])
        Ok(json.to_string_tree(object))
      }
      Error(err) -> Error(err)
    }
  }

  case result {
    Ok(json) -> {
      io.debug(json)
      wisp.json_response(json, 200)
    }
    Error(err) -> {
      io.debug(err)
      wisp.unprocessable_entity()
    }
  }
}

pub fn get_pokemon_by_name(
  req: wisp.Request,
  ctx: context.Context,
  name: String,
) -> wisp.Response {
  use _req <- middleware(req, ctx)

  let result = {
    case pokemon.get_by_name(name, ctx.db) {
      Ok(pkmon) -> {
        let object =
          json.object([
            #("id", json.int(pkmon.id)),
            #("name", json.string(pkmon.name)),
            #("type_1", json.string(pkmon.type_1)),
            #("type_2", json.string(pkmon.type_2)),
            #("total", json.int(pkmon.total)),
            #("attack", json.int(pkmon.attack)),
            #("defense", json.int(pkmon.defense)),
            #("sp_attack", json.int(pkmon.sp_attack)),
            #("sp_defense", json.int(pkmon.sp_defense)),
            #("speed", json.int(pkmon.speed)),
            #("generation", json.int(pkmon.generation)),
            #("legendary", json.bool(pkmon.legendary)),
          ])
        Ok(json.to_string_tree(object))
      }
      Error(err) -> Error(err)
    }
  }

  case result {
    Ok(json) -> {
      io.debug(json)
      wisp.json_response(json, 200)
    }
    Error(err) -> {
      io.debug(err)
      wisp.unprocessable_entity()
    }
  }
}

pub fn get_pokemon_by_search(
  req: wisp.Request,
  ctx: context.Context,
  search: String,
) -> wisp.Response {
  use _req <- middleware(req, ctx)

  let result = {
    case pokemon.get_search(search, ctx.db) {
      Ok(pokemons) -> {
        let object =
          json.array(pokemons, fn(pkmon) {
            json.object([
              #("id", json.int(pkmon.id)),
              #("name", json.string(pkmon.name)),
              #("type_1", json.string(pkmon.type_1)),
              #("type_2", json.string(pkmon.type_2)),
              #("total", json.int(pkmon.total)),
              #("attack", json.int(pkmon.attack)),
              #("defense", json.int(pkmon.defense)),
              #("sp_attack", json.int(pkmon.sp_attack)),
              #("sp_defense", json.int(pkmon.sp_defense)),
              #("speed", json.int(pkmon.speed)),
              #("generation", json.int(pkmon.generation)),
              #("legendary", json.bool(pkmon.legendary)),
            ])
          })
        Ok(json.to_string_tree(object))
      }
      Error(err) -> Error(err)
    }
  }

  case result {
    Ok(json) -> {
      wisp.json_response(json, 200)
    }
    Error(err) -> {
      io.debug(err)
      wisp.unprocessable_entity()
    }
  }
}

pub fn get_all_pokemon(req: wisp.Request, ctx: context.Context) -> wisp.Response {
  use _req <- middleware(req, ctx)

  let result = {
    case pokemon.get_all(ctx.db) {
      Ok(pokemons) -> {
        let object =
          json.array(pokemons, fn(pkmon) {
            json.object([
              #("id", json.int(pkmon.id)),
              #("name", json.string(pkmon.name)),
              #("type_1", json.string(pkmon.type_1)),
              #("type_2", json.string(pkmon.type_2)),
              #("total", json.int(pkmon.total)),
              #("attack", json.int(pkmon.attack)),
              #("defense", json.int(pkmon.defense)),
              #("sp_attack", json.int(pkmon.sp_attack)),
              #("sp_defense", json.int(pkmon.sp_defense)),
              #("speed", json.int(pkmon.speed)),
              #("generation", json.int(pkmon.generation)),
              #("legendary", json.bool(pkmon.legendary)),
            ])
          })
        Ok(json.to_string_tree(object))
      }
      Error(err) -> Error(err)
    }
  }

  case result {
    Ok(json) -> {
      wisp.json_response(json, 200)
    }
    Error(err) -> {
      io.debug(err)
      wisp.unprocessable_entity()
    }
  }
}
