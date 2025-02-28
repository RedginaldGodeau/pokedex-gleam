import core/context
import core/datastore
import core/env
import core/seeder
import gleam/erlang/process
import mist
import model/pokemon
import router/route
import wisp
import wisp/wisp_mist

pub fn main() {
  let environement = env.load_env()
  let db =
    datastore.new_database(
      environement.database_host,
      environement.database_name,
      environement.database_pass,
      environement.database_user,
    )
  let ctx = context.Context(db, environement)

  let assert Ok(count) = pokemon.count(db)
  case count {
    0 -> seeder.pokemon_seeder("./data/pokemon.json", db)
    _ -> Nil
  }

  wisp.configure_logger()
  let assert Ok(_) =
    wisp_mist.handler(fn(req) { route.init_route(req, ctx) }, "")
    |> mist.new
    |> mist.bind("0.0.0.0")
    |> mist.port(environement.backend_port)
    |> mist.start_http
  process.sleep_forever()
}
