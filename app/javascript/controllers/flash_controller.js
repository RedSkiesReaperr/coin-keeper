import {Controller} from "@hotwired/stimulus"
// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ['hide']

  connect() {
    const options = {
      transition: 'transition-opacity',
      duration: 1000,
      timing: 'ease-in-out',

      // callback functions
      onHide: (context, targetEl) => {
        console.log('element has been dismissed')
        console.log(targetEl)
      }
    };

    this.dismissInstance = new Dismiss(this.element, this.hideTarget, options)
  }
}
