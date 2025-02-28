import dot_env
import dot_env/env

pub type Env {
  Env(
    database_host: String,
    database_user: String,
    database_pass: String,
    database_name: String,
    backend_port: Int,
    secret_key_base: String,
  )
}

pub fn load_env() -> Env {
  dot_env.new()
  |> dot_env.set_path(".env.local")
  |> dot_env.set_debug(False)
  |> dot_env.load

  let assert Ok(db_host) = env.get_string("DATABASE_HOST")
  let assert Ok(db_user) = env.get_string("DATABASE_USER")
  let assert Ok(db_password) = env.get_string("DATABASE_PASSWORD")
  let assert Ok(db_name) = env.get_string("DATABASE_NAME")
  let assert Ok(backend_port) = env.get_int("BACKEND_PORT")
  let assert Ok(secret_key_base) = env.get_string("SECRET_KEY_BASE")

  Env(db_host, db_user, db_password, db_name, backend_port, secret_key_base)
}
