import gleam/dynamic/decode
import gleam/json
import gleam/list
import model/pokemon
import pog
import simplifile

pub fn pokemon_seeder(file: String, db: pog.Connection) -> Nil {
  let assert Ok(json_data) = simplifile.read(from: file)
  let pokemon_decoder = {
    use id <- decode.field("id", decode.int)
    use name <- decode.field("name", decode.string)
    use type_1 <- decode.field("type_1", decode.string)
    use type_2 <- decode.field("type_2", decode.string)
    use total <- decode.field("total", decode.int)
    use hp <- decode.field("hp", decode.int)
    use attack <- decode.field("attack", decode.int)
    use defense <- decode.field("defense", decode.int)
    use sp_attack <- decode.field("sp_attack", decode.int)
    use sp_defense <- decode.field("sp_defense", decode.int)
    use speed <- decode.field("speed", decode.int)
    use generation <- decode.field("generation", decode.int)
    use legendary <- decode.field("legendary", decode.bool)
    decode.success(pokemon.Pokemon(
      id:,
      name:,
      type_1:,
      type_2:,
      total:,
      hp:,
      attack:,
      defense:,
      sp_attack:,
      sp_defense:,
      speed:,
      generation:,
      legendary:,
    ))
  }
  let assert Ok(data) =
    json.parse(from: json_data, using: decode.list(pokemon_decoder))
  list.each(data, fn(pkmon) { pokemon.insert(pkmon, db) })

  Nil
}
