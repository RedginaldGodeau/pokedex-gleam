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
  wisp.configure_logger()

  let environement = env.load_env()
  let db =
    datastore.new_database(
      environement.database_host,
      environement.database_name,
      environement.database_pass,
      environement.database_user,
    )
  let ctx = context.Context(db, environement, static_directory())

  let assert Ok(count) = pokemon.count(db)
  case count {
    0 -> seeder.pokemon_seeder("./data/pokemon.json", db)
    _ -> Nil
  }

  let assert Ok(_) =
    wisp_mist.handler(
      fn(req) { route.init_route(req, ctx) },
      environement.secret_key_base,
    )
    |> mist.new
    |> mist.bind("0.0.0.0")
    |> mist.port(environement.backend_port)
    |> mist.start_http
  process.sleep_forever()
}

fn static_directory() -> String {
  let assert Ok(priv_directory) = wisp.priv_directory("backend")
  priv_directory <> "/static"
}
