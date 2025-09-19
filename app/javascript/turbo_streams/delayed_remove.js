import { Turbo } from "@hotwired/turbo"

Turbo.StreamActions.delayed_remove = function() {
  const index = parseInt(this.getAttribute("index"))
  const targetElements = this.targetElements

  if (targetElements) {
    setTimeout(() => {
      targetElements.forEach(element => element.remove())
    }, index * 300)
  }
}
