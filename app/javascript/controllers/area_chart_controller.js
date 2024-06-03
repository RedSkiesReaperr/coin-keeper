import {Controller} from "@hotwired/stimulus"
import ApexCharts from 'apexcharts'
// Connects to data-controller="area-chart"
export default class extends Controller {
  static values = {
    data: Array, // Array<Array<typeof serie>>
    seriesNames: Array, // Array<string>
    seriesColors: Array, // Array<string>
    labels: Array  // Array<string>
  }

  connect() {
    this.render()
  }

  buildSeries() {
    let series = []

    for (let i = 0; i < this.dataValue.length; i++) {
      let curr_serie = {
        name: this.seriesNamesValue[i],
        data: [],
        color: this.seriesColorsValue[i]
      }

      for (let j = 0; j < this.dataValue[i].length; j++) {
        curr_serie.data.push(this.dataValue[i][j].amount)
      }

      series.push(curr_serie)
    }

    return series;
  }

  render() {
    const options = {
      chart: {
        height: "100%",
        maxWidth: "100%",
        type: "area",
        fontFamily: "Inter, sans-serif",
        dropShadow: {
          enabled: false,
        },
        toolbar: {
          show: false,
        },
      },
      tooltip: {
        enabled: true,
        x: {
          show: false,
        },
      },
      fill: {
        type: "gradient",
        gradient: {
          opacityFrom: 0.55,
          opacityTo: 0,
          shade: "#2ecc71",
          gradientToColors: ["#27ae60"],
        },
      },
      dataLabels: {
        enabled: false,
      },
      stroke: {
        width: 6,
      },
      grid: {
        show: false,
        strokeDashArray: 4,
        padding: {
          left: 2,
          right: 2,
          top: 0
        },
      },
      series: this.buildSeries(),
      xaxis: {
        categories: this.labelsValue,
        labels: {
          show: false,
        },
        axisBorder: {
          show: false,
        },
        axisTicks: {
          show: false,
        },
      },
      yaxis: {
        show: false,
      },
    }

    if (typeof ApexCharts !== 'undefined') {
      const chart = new ApexCharts(this.element, options);
      chart.render();
    }
  }
}
