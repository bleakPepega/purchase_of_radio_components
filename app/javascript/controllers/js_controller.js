import { Application } from '@hotwired/stimulus'
import Carousel from 'stimulus-carousel'
import { Autocomplete } from 'stimulus-autocomplete'

const application = Application.start()
application.register('carousel', Carousel)
application.register('autocomplete', Autocomplete)
