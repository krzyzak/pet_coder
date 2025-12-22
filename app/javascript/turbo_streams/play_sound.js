import { Turbo } from "@hotwired/turbo"

Turbo.StreamActions.play_sound = function() {
  const sound = this.getAttribute('sound');
  const index = parseInt(this.getAttribute("index"))

  setTimeout(() => {
    document.getElementById(`${sound}_sound`).play();
  }, index * 300)
}
