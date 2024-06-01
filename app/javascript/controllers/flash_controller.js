import {Controller} from "@hotwired/stimulus"
// Connects to data-controller="flash"
export default class extends Controller {
    connect() {
        setTimeout(() => {
            this.hide()
        }, 5000)
    }

    hide() {
        this.element.remove()
    }
}
