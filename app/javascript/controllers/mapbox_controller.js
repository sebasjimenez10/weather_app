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

      // mapboxsearch.on("retrieve", (res) => {
      //   const feature = res.features[0]

      //   // Preferred order of fallback:
      //   const fullAddress =
      //     feature.properties.full_address || // most structured, if available
      //     feature.place_name ||              // fallback from Mapbox
      //     feature.properties.address         // very basic, least reliable

      //   this.inputTarget.value = fullAddress
      // })
    })

    // script.onload = () => {
    //   mapboxsearch.config.accessToken = ACCESS_TOKEN

    //   mapboxsearch.autofill({
    //     options: {
    //       country: 'us'
    //     }
    //   })

    //   // mapboxsearch.autofill({
    //   //   accessToken: ACCESS_TOKEN,
    //   //   types: ["address"],
    //   //   placeholder: "Enter address",
    //   //   options: {
    //   //     country: 'us'
    //   //   }
    //   // })

    //   // mapboxsearch.attach(this.inputTarget)

    //   // mapboxsearch.on("retrieve", (res) => {
    //   //   const feature = res.features[0]

    //   //   // Preferred order of fallback:
    //   //   const fullAddress =
    //   //     feature.properties.full_address || // most structured, if available
    //   //     feature.place_name ||              // fallback from Mapbox
    //   //     feature.properties.address         // very basic, least reliable

    //   //   this.inputTarget.value = fullAddress
    //   // })
    // };

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