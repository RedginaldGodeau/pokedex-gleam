import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn layout(elements: List(Element(t)), title: String) -> Element(t) {
  html.html([], [
    html.head([], [
      html.title([], title),
      html.meta([
        attribute.name("viewport"),
        attribute.attribute("content", "width=device-width, initial-scale=1"),
      ]),
      html.link([
        attribute.rel("stylesheet"),
        attribute.href("/static/main.css"),
      ]),
    ]),
    html.body([], elements),
  ])
}
