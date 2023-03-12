import { Application } from "@hotwired/stimulus"
import Carousel from 'stimulus-carousel'
import { Autocomplete } from 'stimulus-autocomplete'


const application = Application.start()


// Configure Stimulus development experience
Application.debug = true
window.Stimulus   = application

export { application }
import 'swiper/css/bundle'
