import core/env
import pog

pub type Context {
  Context(db: pog.Connection, env: env.Env, static_directory: String)
}
