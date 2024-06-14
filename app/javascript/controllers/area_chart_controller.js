import {Controller} from "@hotwired/stimulus"
import ApexCharts from 'apexcharts'
// Connects to data-controller="area-chart"
export default class extends Controller {
  static targets = "chart"
  static values = {
    data: Array, // Array<Array<typeof serie>>
    seriesNames: Array, // Array<string>
    seriesColors: Array, // Array<string>
    strokeWidth: Number
  }

  connect() {
    this.chartTarget = new ApexCharts(this.element, this.chartOptions);
    this.chartTarget.render();
  }

  disconnect() {
    this.chartTarget.destroy();
  }

  get series() {
    let series = []

    for (let serieKey = 0; serieKey < this.dataValue.length; serieKey++) {
      let newSerie = {
        name: this.seriesNamesValue[serieKey],
        data: [],
        color: this.seriesColorsValue[serieKey]
      }

      for (let serie = 0; serie < this.dataValue[serieKey].length; serie++) {
        newSerie.data.push(this.dataValue[serieKey][serie].value)
      }

      series.push(newSerie)
    }

    return series;
  }

  get labels() {
    let labels = []

    for (let serieKey = 0; serieKey < this.dataValue.length; serieKey++) {
      for (let serie = 0; serie < this.dataValue[serieKey].length; serie++) {
        let key = this.dataValue[serieKey][serie].key
        let label = new Date(key).toLocaleDateString()

        if (label !== 'Invalid Date') {
          labels.push(label)
        } else {
          labels.push(key)
        }
      }
    }

    return labels;
  }

  get chartOptions() {
    return {
      chart: {
        height: "100%",
        width: "100%",
        type: "area",
        dropShadow: {
          enabled: false,
        },
        toolbar: {
          show: false,
        },
      },
      tooltip: {
        enabled: true,
      },
      fill: {
        type: "gradient",
        gradient: {
          opacityFrom: 0.55,
          opacityTo: 0,
        },
      },
      dataLabels: {
        enabled: false,
      },
      stroke: {
        width: this.strokeWidthValue || 6,
      },
      grid: {
        show: false,
        strokeDashArray: 4,
        padding: {
          top: 0,
          right: 1,
          bottom: 0,
          left: 1
        }
      },
      series: this.series,
      xaxis: {
        categories: this.labels,
        labels: {
          show: false,
        },
        axisBorder: {
          show: false,
        },
        axisTicks: {
          show: false,
        },
        tooltip: {
          enabled: false
        }
      },
      yaxis: {
        show: false,
      },
    }
  }
}
