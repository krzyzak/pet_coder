import { Turbo } from "@hotwired/turbo"

Turbo.StreamActions.turbo_redirect = function () {
  const url = this.getAttribute("url")
  const index = parseInt(this.getAttribute("index"))

  setTimeout(() => {
    Turbo.visit(url)
  }, index * 300)
}
