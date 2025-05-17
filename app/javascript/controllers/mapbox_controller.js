import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    const accessToken = document.querySelector("meta[name='mapbox-token']").content

    this.loadMapbox().then((mapboxsearch) => {
      mapboxsearch.config.accessToken = accessToken
      const autofill = mapboxsearch.autofill({
        types: ["address"],
        options: { country: 'us' }
      })

      autofill.addEventListener('retrieve', (event) => {
        const props = event.detail.features[0].properties
        const parts = [
          props.address_line1,  // "76 Deerfield Avenue"
          props.address_level2, // "Irvine"
          props.address_level1, // "CA"
          props.postcode        // "92606"
        ]

        const fullAddress = parts.filter((p) => !!p).join(", ")

        setTimeout(() => {
          this.inputTarget.value = fullAddress
        }, 0)
      });
    })

    this.inputTarget.closest("form").addEventListener("submit", (e) => {
      e.preventDefault()
    })
  }

  loadMapbox() {
    return new Promise((resolve) => {
      const script = document.getElementById('search-js')

      if (window.mapboxsearch) return resolve(window.mapboxsearch)

      script.onload = () => {
        resolve(window.mapboxsearch)
      }
    })
  }
}