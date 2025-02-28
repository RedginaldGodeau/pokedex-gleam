import gleam/option
import model/pokemon
import pog

pub fn new_database(host: String, db: String, password: String, user: String) {
  let db =
    pog.default_config()
    |> pog.host(host)
    |> pog.database(db)
    |> pog.password(option.Some(password))
    |> pog.user(user)
    |> pog.pool_size(15)
    |> pog.connect

  let _ = pog.execute(pog.query(pokemon.schema), db)
  db
}
