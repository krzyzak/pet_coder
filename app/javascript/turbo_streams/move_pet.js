import { Turbo } from "@hotwired/turbo"

Turbo.StreamActions.move_pet = function() {
  const x = parseInt(this.getAttribute("x"))
  const y = parseInt(this.getAttribute("y"))
  const index = parseInt(this.getAttribute("index"))

  const petElement = this.targetElements[0]

  if (petElement) {
    setTimeout(() => {
      petElement.style.transition = "left 0.3s ease, top 0.3s ease"
      petElement.style.left = `${x * 80}px`
      petElement.style.top = `${y * 80}px`
    }, index * 300)
  }
}
