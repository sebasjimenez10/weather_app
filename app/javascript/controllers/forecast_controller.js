import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.inputTarget.addEventListener("keypress", event => {
      if (event.key === "Enter") {
        event.preventDefault()
        this.go()
      }
    })
  }

  load() {
    const address = this.inputTarget.value.trim()

    if (address !== "") {
      window.location.href = `/forecasts/${encodeURIComponent(address)}`
    }
  }
}
