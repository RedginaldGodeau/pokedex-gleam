import gleam/int
import gleam/list
import lustre/attribute
import lustre/element.{type Element, text}
import lustre/element/html.{a, div, h1, h3, p}
import model/pokemon

pub fn root(items: List(pokemon.Pokemon)) -> Element(t) {
  div([], [
    h1([], [text("Homepage")]),
    div(
      [],
      items
        |> list.map(pokemon_item),
    ),
  ])
}

fn pokemon_item(pkmon: pokemon.Pokemon) -> Element(t) {
  a([attribute.href("/pokemon/" <> int.to_string(pkmon.id))], [
    div([], [
      h3([attribute.class("text-3xl text-red-500")], [text(pkmon.name)]),
      p([], [text(pkmon.type_1)]),
      p([], [text(pkmon.type_2)]),
    ]),
  ])
}
