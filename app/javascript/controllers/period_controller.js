import Form_controller from "./form_controller";

// Connects to data-controller="period"
export default class extends Form_controller {
  static targets = ["start", "end", "range"]
  static values = {
    startDefault: String,
    endDefault: String
  }

  initialize() {
    this.startDateValue = new Date(this.startDefaultValue)
    this.endDateValue = new Date(this.endDefaultValue)
  }

  connect() {
    this.rangeTargetValue = new Datepicker(this.rangeTarget, this.inputOptions)
    this.rangeTargetValue.getDatepickerInstance().setDates(this.startDateValue, this.endDateValue)

    this.startTarget.addEventListener('changeDate', (e) => {
      this.submit()
    })

    this.endTarget.addEventListener('changeDate', (e) => {
      this.submit()
    })
  }

  get inputOptions() {
    return {
      rangePicker: true,
      autohide: false,
      format: 'dd/mm/yyyy',
    }
  }
}
