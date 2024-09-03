import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["notice"]

  connect() {
    console.log('lol')
    
    setTimeout(() => {
      this.noticeTarget.style.display = "none"
    }, 3000)  // Hides the notice after 3 seconds
  }
}
