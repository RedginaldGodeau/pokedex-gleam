import gleam/int
import lustre/attribute
import lustre/element.{type Element, none, text}
import lustre/element/html.{a, div, h1, p}
import model/pokemon

pub fn root(item: pokemon.Pokemon) -> Element(t) {
  div([], [
    a([attribute.href("/")], [text("Revenir en arrière")]),
    h1([], [text(item.name)]),
    div([], [
      p([], [text("Type: " <> item.type_1 <> " " <> item.type_2)]),
      p([], [text("Generation: " <> int.to_string(item.generation))]),
      case item.legendary {
        True -> p([], [text("Legendaire")])
        False -> none()
      },
    ]),
    p([], [text("Total: " <> int.to_string(item.total))]),
    p([], [text("Point de vie: " <> int.to_string(item.hp))]),
    p([], [text("Attaque: " <> int.to_string(item.attack))]),
    p([], [text("Défense: " <> int.to_string(item.defense))]),
    p([], [text("Attaque spécial: " <> int.to_string(item.sp_attack))]),
    p([], [text("Défense spécial: " <> int.to_string(item.sp_defense))]),
    p([], [text("Vitesse: " <> int.to_string(item.speed))]),
    div([], [
      case item.id != 1 {
        True ->
          p([], [
            a([attribute.href("/pokemon/" <> int.to_string(item.id - 1))], [
              text("Précédent"),
            ]),
          ])
        False -> none()
      },
      a([attribute.href("/pokemon/" <> int.to_string(item.id + 1))], [
        text("Suivant"),
      ]),
    ]),
  ])
}
