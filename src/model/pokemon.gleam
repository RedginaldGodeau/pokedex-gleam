import gleam/dynamic/decode
import gleam/io
import pog

pub type Pokemon {
  Pokemon(
    id: Int,
    name: String,
    type_1: String,
    type_2: String,
    total: Int,
    hp: Int,
    attack: Int,
    defense: Int,
    sp_attack: Int,
    sp_defense: Int,
    speed: Int,
    generation: Int,
    legendary: Bool,
  )
}

pub fn pokemon_decoder() -> decode.Decoder(Pokemon) {
  use id <- decode.field(0, decode.int)
  use name <- decode.field(1, decode.string)
  use type_1 <- decode.field(2, decode.string)
  use type_2 <- decode.field(3, decode.string)
  use total <- decode.field(4, decode.int)
  use hp <- decode.field(5, decode.int)
  use attack <- decode.field(6, decode.int)
  use defense <- decode.field(7, decode.int)
  use sp_attack <- decode.field(8, decode.int)
  use sp_defense <- decode.field(9, decode.int)
  use speed <- decode.field(10, decode.int)
  use generation <- decode.field(11, decode.int)
  use legendary <- decode.field(12, decode.bool)
  decode.success(Pokemon(
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

pub const schema = "create table IF NOT EXISTS pokemon (
  id serial primary key,
  name varchar(255) not null,
  type_1 varchar(255) not null,
  type_2 varchar(255) not null,
  total INT not null,
  hp INT not null,
  attack INT not null,
  defense INT not null,
  sp_attack INT not null,
  sp_defense INT not null,
  speed INT not null,
  generation INT not null,
  legendary BOOLEAN not null
);"

pub fn get_by_id(id: Int, db: pog.Connection) -> Result(Pokemon, String) {
  let sql_query =
    "
    SELECT id, name, type_1, type_2, total, hp, attack, defense, sp_attack, sp_defense, speed, generation, legendary
    FROM pokemon
    WHERE pokedex_id = $1;
    "

  let row_decoder = {
    pokemon_decoder()
  }

  let query =
    pog.query(sql_query)
    |> pog.parameter(pog.int(id))
    |> pog.returning(row_decoder)
    |> pog.execute(db)

  case query {
    Ok(response) -> {
      case response.rows {
        [pokemon] -> Ok(pokemon)
        [] -> Error("Aucun Pokemon trouvé")
        _ -> Error("Aucun Pokemon trouvé 2")
      }
    }
    Error(err) -> {
      io.debug(err)
      Error("Erreur lors de la request SQL")
    }
  }
}

pub fn get_by_name(name: String, db: pog.Connection) -> Result(Pokemon, String) {
  let sql_query =
    "
    SELECT id, name, type_1, type_2, total, hp, attack, defense, sp_attack, sp_defense, speed, generation, legendary
    FROM pokemon
    WHERE name = $1;
    "

  let row_decoder = {
    pokemon_decoder()
  }

  let query =
    pog.query(sql_query)
    |> pog.parameter(pog.text(name))
    |> pog.returning(row_decoder)
    |> pog.execute(db)

  case query {
    Ok(response) -> {
      case response.rows {
        [pokemon] -> Ok(pokemon)
        [] -> Error("Aucun Pokemon trouvé")
        _ -> Error("Aucun Pokemon trouvé 2")
      }
    }
    Error(_) -> Error("Erreur lors de la request SQL")
  }
}

pub fn count(db: pog.Connection) -> Result(Int, String) {
  let sql_query = "SELECT FROM pokemon;"

  let query =
    pog.query(sql_query)
    |> pog.execute(db)

  case query {
    Ok(response) -> Ok(response.count)
    Error(_) -> Error("Une erreur est survenur lors de la requete")
  }
}

pub fn insert(self: Pokemon, db: pog.Connection) -> Result(Nil, String) {
  let sql_query =
    "
    INSERT INTO pokemon 
    (pokedex_id, name, type_1, type_2, total, hp, attack, defense, sp_attack, sp_defense, speed, generation, legendary)
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13);
    "

  let query =
    pog.query(sql_query)
    |> pog.parameter(pog.int(self.id))
    |> pog.parameter(pog.text(self.name))
    |> pog.parameter(pog.text(self.type_1))
    |> pog.parameter(pog.text(self.type_2))
    |> pog.parameter(pog.int(self.total))
    |> pog.parameter(pog.int(self.hp))
    |> pog.parameter(pog.int(self.attack))
    |> pog.parameter(pog.int(self.defense))
    |> pog.parameter(pog.int(self.sp_attack))
    |> pog.parameter(pog.int(self.sp_defense))
    |> pog.parameter(pog.int(self.speed))
    |> pog.parameter(pog.int(self.generation))
    |> pog.parameter(pog.bool(self.legendary))
    |> pog.execute(db)

  case query {
    Ok(_) -> Ok(Nil)
    Error(_) -> Error("Une erreur est survenu lors de l'insert")
  }
}
