import { Controller } from "@hotwired/stimulus"
import _debounce from 'lodash.debounce'

// Connects to data-controller="form"
export default class extends Controller {
  connect() {
    this.debouncedSubmit = _debounce(this.submit, 700).bind(this)
  }

  submit() {
    this.element.requestSubmit()
  }

  debouncedSubmit() {
    this.submit()
  }

  reset() {
    this.element.reset()
  }

  submitAndReset() {
    this.submit()
    this.reset()
  }

  resetAndSubmit() {
    this.reset()
    this.submit()
  }
}
