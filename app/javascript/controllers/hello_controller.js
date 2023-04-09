import {Controller} from "@hotwired/stimulus"
import axios from "axios";

export default class extends Controller {
    connect() {

        this.count = 0;
    }

    initialize() {

    }

    handleClick() {


        const formData = new FormData();

        for (let i = 0; i < 50; i++) {
            if (document.querySelector( `#name-${i}`) != null) {
                if (document.querySelector(`#name-${i}`).value != "") {
                    formData.append(`quantity-${i}`, document.querySelector(`#quantityInput-${i}`).value)
                    formData.append(`name-${i}`, document.querySelector(`#name-${i}`).value)
                    formData.append(`cash-${i}`, document.querySelector('input[name="cash"]:checked').value);
                }

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
        const blockContainer = document.createElement("div");
        blockContainer.classList.add("w-full", "grid", "grid-cols-5", "text-center", "gap-y-4", "py-2");
        blockContainer.id = `block-${this.count}`;
    	const nameComponent =  document.createElement('div');
    	nameComponent.classList.add("flex", "flex-col", "w-full", "justify-center", "px-2" )
    	const groupComponent = document.createElement('div');
    	groupComponent.classList.add("flex", "flex-col",  "w-full", "justify-center", "px-2")
    	const quantityInput = document.createElement('div');
    	quantityInput.classList.add("flex", "flex-col", "w-full", "justify-center", "px-2")
    	const mock1 = document.createElement('div');
    	mock1.classList.add("flex", "flex-col", "w-full", "justify-center", "px-2")
    	const mock2 = document.createElement('div');
    	mock2.classList.add("flex", "flex-col", "w-full", "justify-center", "items-center", "px-2")
    	const divider = document.createElement('div')
    	divider.classList.add("flex", "col-span-5", "h-px", "bg-gray-300")

        nameComponent.innerHTML = `
  <div data-controller="autocomplete" class="flex flex-col w-full relative">
    <input type="text" id="name-${this.count}" name="name-${this.count}" data-target="autocomplete.input" data-action="input->autocomplete#search" placeholder="Введите название элемента" class= "text-sm" role="combobox" class="w-full">
    <ul class="absolute z-10 top-0 left-0 right-0 mt-10 min-w-full w-auto max-w-xl mr-2 max-h-48 overflow-y-auto bg-white" data-target="autocomplete.list"></ul>
  </div>`;
    blockContainer.appendChild(nameComponent);
        groupComponent.innerHTML = `
	  <input id="group-${this.count}" name="group-${this.count}" type="text"  placeholder="Подгруппа" class= "text-sm" readonly>
        `;
        blockContainer.appendChild(groupComponent);
        quantityInput.innerHTML = `
          <div data-controller="hello" class="flex flex-col w-full relative">
            <input name="quantityInput-${this.count}" id="quantityInput-${this.count}" min="1" value="1" type="number" data-action="input->hello#handleClick">
    `;
        blockContainer.appendChild(quantityInput);

        mock2.innerHTML = `
           <div data-controller="hello" class="flex flex-col w-full relative items-center">
             <button
                data-block-id="block-${this.count}"
                data-action="click->hello#removeBlock click->hello#handleClick"
                class="flex w-32 h-8 bg-red-500 rounded-xl hover:bg-red-400 text-white font-bold px-4 border-b-4 border-red-700 hover:border-red-500 items-center justify-center ">
                Удалить
            </button>
           </div>

        `
        blockContainer.appendChild(mock2);
        blockContainer.appendChild(mock1);


//        blockContainer.appendChild(quantityInput);
//        blockContainer.appendChild(mock2);
//	    container.appendChild(divider);
//        container.appendChild(nameComponent);
//	    container.appendChild(groupComponent);
//        container.appendChild(quantityInput);
//	    container.appendChild(mock1);
//        container.appendChild(mock2);
        container.appendChild(blockContainer);
    }

    removeBlock(event) {
        console.log("worked")
        const blockId = event.target.dataset.blockId;
        const block = document.getElementById(blockId);
        if (block) {
            block.remove();
        }
    }

}
