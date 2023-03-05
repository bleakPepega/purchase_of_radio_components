import {Controller} from "@hotwired/stimulus"
import axios from "axios";

export default class extends Controller {
    static targets = ["input", "autocompleteDatalist", "group", "output", "quantityInput"];

    connect() {
        console.log("pqwjpqjpjpwjdppqwjdjpqwjdpqd")
        this.loadData();
    }
    submit() {
        const inputValue = this.inputTarget.value
        const kol = this.quantityInputTarget.value
        const year = this.getSelectedYear()
        const data = { name: inputValue, quantity: kol, year: year }
        axios.post('/process_input_value', { value: data})
            .then(response => {
                console.log(response.data)
                this.outputTarget.textContent = `Зн: ${response.data}`
            })
    }
    loadData() {
        fetch('/pages/autocomplete_data')
            .then(response => response.json())
            .then(data => {
                this.autocompleteDatalistTarget.innerHTML = "";
                data.forEach((option) => {
                    let optionElement = document.createElement("option");
                    optionElement.value = option;
                    this.autocompleteDatalistTarget.appendChild(optionElement);
                });
            });
    }
    getSelectedYear() {
        return this.element.querySelector('input[name="pay"]:checked').value;
    }
}
