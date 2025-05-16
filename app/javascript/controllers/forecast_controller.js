import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    // Adds an event listener to the input field to handle the Enter key
    this.inputTarget.addEventListener("keypress", event => {
      if (event.key === "Enter") {
        event.preventDefault()
        this.load()
      }
    })
  }

  // This method is called when the user clicks the "Get Forecast" button
  load() {
    const address = this.inputTarget.value.trim()

    if (address !== "") {
      window.location.href = `/forecasts/${encodeURIComponent(address)}`
    }
  }
}
