import { Controller } from "@hotwired/stimulus"
import axios from "axios"

export default class extends Controller {
    static targets = ["groupSelect"]

    selectGroup(event) {
        const groupValue = this.groupSelectTarget.value
        axios.post("/process_group_value", {group: groupValue})
            .then(response => {
                const data = response.data
                console.log(data)
                const datalist = document.querySelector('#autocomplete-datalist'); // получаем DOM-элемент datalist
        datalist.innerHTML = ''; // очищаем список
        data.forEach((option) => { // добавляем новые значения
            let optionElement = document.createElement('option');
            optionElement.value = option;
            datalist.appendChild(optionElement);
        });
            })

    }

}
