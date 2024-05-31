import {Controller} from "@hotwired/stimulus"
import _debounce from 'lodash.debounce'
// Connects to data-controller="filtering-form"
export default class extends Controller {
    connect() {
        this.onQueryChanged = _debounce(this.submit, 700).bind(this)
    }

    clear() {
        this.element.reset()
        this.submit()
    }

    onQueryChanged() {
        this.submit()
    }

    onPointedChanged() {
        this.submit()
    }

    onIgnoredChanged() {
        this.submit()
    }

    submit() {
        this.element.requestSubmit()
    }
}
