import { Controller } from "@hotwired/stimulus"
import axios from "axios"

export default class extends Controller {
    static targets = [ "input", "list" ]
    connect() {

        this.inputTarget.addEventListener('blur', () => {
            setTimeout(() => {
                if (!this.listTarget.querySelector('li:hover')) {
                    this.listTarget.innerHTML = '';
                }
            }, 100); // устанавливаем таймаут для того, чтобы пользователь успел кликнуть по элементу списка
        });
        this.setUpEventListener();

    }
    search() {
        const query = this.inputTarget.value
        axios.get(`/process_group_value?q=${query}`)
            .then(response => {
                this.listTarget.innerHTML = ''
                response.data.forEach(item => {
                    const listItem = document.createElement('li')
                    listItem.textContent = item
                    listItem.classList.add('border', 'border-gray-300', 'hover:bg-gray-200', 'hover:text-black') // добавление классов обводки и классов при наведении
                    listItem.addEventListener('click', () => {
                        this.inputTarget.value = item
                        this.listTarget.innerHTML = ''
                        this.dispatchSelectedEvent(item) // вызываем событие "selected" с выбранным элементом
                    })
                    this.listTarget.appendChild(listItem)
                })
            })
            .catch(error => {
                console.log(error)
            })
    }



    dispatchSelectedEvent(item) {
        const event = new CustomEvent('selected', { detail: { value: item } })
        this.element.dispatchEvent(event)
    }

    setUpEventListener() {
        const formData = new FormData();

        this.element.addEventListener('selected', event => {
            console.log('Выбран элемент:', event.detail.value)
            this.handleClick()
            formData.append("name", event.detail.value);
            fetch("/get_group", {
                method: "POST",
                body: formData
            }).then(response => {
                if (response.ok) {
                    return response.json(); // обрабатываем JSON-данные
                } else {
                    throw new Error('Network response was not ok.');
                }
            }).then(data => {

                const selectedElement = event.target;
                // Находим ближайший родительский элемент с атрибутом data-controller="autocomplete"
                const parentElement = selectedElement.closest('[data-controller="autocomplete"]');

                // Получаем элемент input внутри parentElement
                const inputElement = parentElement.querySelector('input');

                // Получаем id и name элемента input
                const elementId = inputElement.id;
                const elementName = inputElement.name;

                for (let i = 0; i < 50; i++) {
                    if (elementName == `name-${i}`) {
                        document.querySelector(`#group-${i}`).value = data.value
                    }
                }

            }).catch(error => {
                console.error('There was a problem with the fetch operation:', error);
            });
        });
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

}
