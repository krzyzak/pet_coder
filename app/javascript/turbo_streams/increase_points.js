import { Turbo } from "@hotwired/turbo"

Turbo.StreamActions.increase_points = function() {
  const amount = parseInt(this.getAttribute("amount"))
  const pointsElement = document.getElementById("points")
  const index = parseInt(this.getAttribute("index"))

  if (pointsElement && amount) {
    setTimeout(() => {
      const currentText = pointsElement.textContent
      const currentPoints = parseInt(currentText.match(/\d+/)[0])
      const newPoints = currentPoints + amount

      pointsElement.style.transition = "transform 0.3s ease, color 0.3s ease"
      pointsElement.style.transform = "scale(1.2)"
      pointsElement.style.color = "#10b981" // green color

      pointsElement.textContent = `Points: ${newPoints}`

      setTimeout(() => {
        pointsElement.style.transform = "scale(1)"
        pointsElement.style.color = ""
      }, 300)
    }, index * 300)
  }
}
