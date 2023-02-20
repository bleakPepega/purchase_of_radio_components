// app/javascript/controllers/calculator_controller.js
import { Controller } from "stimulus"

export default class extends Controller {
    static targets = [ "elementSelect" ]

    connect() {
        this.loadElements()
    }

    loadElements() {
        const group = document.querySelector("#group").value
        fetch(`/products/calculator?group=${group}`)
            .then(response => response.json())
            .then(data => {
                this.elementSelectTarget.innerHTML = ""
                data.forEach(element => {
                    const option = document.createElement("option")
                    option.value = element.id
                    option.text = element.name
                    this.elementSelectTarget.appendChild(option)
                })
            })
    }
}
