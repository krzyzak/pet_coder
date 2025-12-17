import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["backgroundMusic"];

  playBackgroundMusic() {
    this.backgroundMusicTarget.play();
  }
}
