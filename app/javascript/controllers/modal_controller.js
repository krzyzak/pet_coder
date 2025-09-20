import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]
  static values = {
    autoShow: Boolean,
  }

  connect() {
    if (this.autoShowValue) {
      this.show()
    }
  }

  show() {
    this.modalTarget.classList.remove('hidden')
    this.modalTarget.classList.add('flex')
  }

  hide() {
    this.modalTarget.classList.add('hidden')
    this.modalTarget.classList.remove('flex')
  }

  backdropClick(event) {
    if (event.target === this.modalTarget) {
      this.hide()
    }
  }
}
