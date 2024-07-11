import {Controller} from "@hotwired/stimulus"
// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ['hide']

  connect() {
    this.dismissInstance = new Dismiss(this.element, this.hideTarget, this.options)

    setTimeout(() => {
      this.dismissInstance.hide()
    }, 3000)
  }

  get options() {
    return {
      transition: 'transition-opacity',
      duration: 1000,
      timing: 'ease-in-out',
    }
  }
}
