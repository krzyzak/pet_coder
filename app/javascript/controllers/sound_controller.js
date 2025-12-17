import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["backgroundMusic", "gameOver", "gameCompleted"];

  playBackgroundMusic() {
    if (this.hasBackgroundMusicTarget) {
      this.backgroundMusicTarget.play().catch(e => console.error("Could not play background music", e));
    }
  }

  gameOverTargetConnected(element) {
    if (!document.documentElement.hasAttribute('data-turbo-preview')) {
      element.play().catch(e => console.error("Could not play game over sound", e));
    }
  }

  gameCompletedTargetConnected(element) {
    if (!document.documentElement.hasAttribute('data-turbo-preview')) {
      element.play().catch(e => console.error("Could not play game completed sound", e));
    }
  }
}
