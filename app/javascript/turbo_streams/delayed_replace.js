import { Turbo } from "@hotwired/turbo"

Turbo.StreamActions.delayed_replace = function() {
  const index = parseInt(this.getAttribute("index"))
  const targetElements = this.targetElements

  if (targetElements) {
    setTimeout(() => {
      targetElements.forEach(element => element.replaceWith(this.templateContent))
    }, index * 300)
  }
}
