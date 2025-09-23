import { Turbo } from "@hotwired/turbo"

Turbo.StreamActions.animate_pet_opening = function() {
  const index = parseInt(this.getAttribute("index"))
  const petElement = document.getElementById("pet")

  if (petElement) {
    setTimeout(() => {
      petElement.style.transition = "transform 0.3s ease, filter 0.3s ease"
      petElement.style.transform = "scale(1.1)"
      petElement.style.filter = "drop-shadow(0 0 10px rgba(59, 130, 246, 0.8))"

      setTimeout(() => {
        petElement.style.transform = "scale(1)"
        petElement.style.filter = ""
      }, 300)
    }, index * 300)
  }
}
