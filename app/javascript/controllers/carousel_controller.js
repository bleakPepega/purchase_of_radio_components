import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['items']
    static values = { slide: Boolean }

    connect() {

        this.show()
    }

    prev() {
        this.index--
        this.show()
    }

    next() {
        this.index++
        this.show()
    }

    show() {
        this.itemsTargets.forEach((el, i) => {
            const active = this.index == i
            el.classList.toggle('active', active)
            el.setAttribute('aria-hidden', !active)
            el.setAttribute('aria-selected', active)
            el.setAttribute('tabindex', active ? 0 : -1)
        })
    }

    get index() {
        return parseInt(this.data.get('index')) || 0
    }

    set index(value) {
        this.data.set('index', value)
    }

    get slide() {
        return this.hasSlideValue ? this.slideValue : true
    }

    get hasSlideValue() {
        return this.hasValue('slide')
    }
}
