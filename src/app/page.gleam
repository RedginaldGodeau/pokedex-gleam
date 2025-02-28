import app/page/home
import app/page/poke
import model/pokemon

pub fn home_page(pokemons: List(pokemon.Pokemon)) {
  home.root(pokemons)
}

pub fn pokemon_page(pkmn: pokemon.Pokemon) {
  poke.root(pkmn)
}
