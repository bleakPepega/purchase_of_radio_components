import {Controller} from "@hotwired/stimulus"
import axios from "axios";

export default class extends Controller {
    connect() {

        this.count = 0;
    }

    initialize() {

    }

    handleClick(event) {


        const formData = new FormData();

        for (let i = 0; i < 10; i++) {
            if (document.querySelector( `#name-${i}`) != null) {
                formData.append(`quantity-${i}`, document.querySelector(`#quantityInput-${i}`).value)
                formData.append(`name-${i}`, document.querySelector(`#name-${i}`).value)
                formData.append(`cash-${i}`, document.querySelector('input[name="cash"]:checked').value);

            }
        }

            fetch("/test", {
            method: "POST",
            body: formData
        }).then(response => {
            if (response.ok) {
                return response.json(); // обрабатываем JSON-данные
            } else {
                throw new Error('Network response was not ok.');
            }
        }).then(data => {
            const output = document.querySelector("#test111")
            output.value = data;
        }).catch(error => {
            console.error('There was a problem with the fetch operation:', error);
        });
    }
    addBlock() {
        this.count++
        const container = document.querySelector('#container');

	//        const newField = document.createElement('div');

	const nameComponent =  document.createElement('div');
	nameComponent.classList.add("flex", "flex-col", "w-full", "justify-center", "px-2" )
	const groupComponent = document.createElement('div');
	groupComponent.classList.add("flex", "flex-col",  "w-full", "justify-center", "px-2")
	const quantityInput = document.createElement('div');
	quantityInput.classList.add("flex", "flex-col", "w-full", "justify-center", "px-2")
	const mock1 = document.createElement('div');
	mock1.classList.add("flex", "flex-col", "w-full", "justify-center", "px-2")
	const mock2 = document.createElement('div');
	mock2.classList.add("flex", "flex-col", "w-full", "justify-center", "px-2")
	const divider = document.createElement('div')
	divider.classList.add("flex", "col-span-5", "h-px", "bg-gray-300")

        nameComponent.innerHTML = `
  <div data-controller="autocomplete" class="flex flex-col w-full relative">
    <input type="text" id="name-${this.count}" name="name-${this.count}" data-target="autocomplete.input" data-action="input->autocomplete#search" role="combobox" class="w-full">
    <ul class="absolute z-10 top-0 left-0 right-0 mt-10 min-w-full w-auto max-w-xl mr-2 max-h-48 overflow-y-auto bg-white border border-gray-300" data-target="autocomplete.list"></ul>
  </div>`;



        groupComponent.innerHTML = `
	  <input id="group-${this.count}" name="group-${this.count}" type="text"  placeholder="Группа" readonly>
        `;
	quantityInput.innerHTML = ` <input name="quantityInput-${this.count}" id="quantityInput-${this.count}" min="1" value="1" type="number">
    `;


	container.appendChild(divider);
        container.appendChild(nameComponent);
	container.appendChild(groupComponent);
        container.appendChild(quantityInput);
	container.appendChild(mock1);
        container.appendChild(mock2);



        const newAutocompleteElement = newField.querySelector('[data-controller="autocomplete"]');
        const application = this.application;
        application.getControllerForElementAndIdentifier(newAutocompleteElement, 'autocomplete');
    }


}
