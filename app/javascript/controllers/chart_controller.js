import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

export default class extends Controller {
  static targets = []

  connect() {
    this.canvas = document.createElement("canvas");
    this.element.appendChild(this.canvas);
    var chartData = JSON.parse(chartElement.getAttribute('data-chart-data'));
    var chartLabels = JSON.parse(chartElement.getAttribute('data-chart-labels'));

    // const worldPopulationGrowth = {
    //   app_1: 1,
    //   app_2: 7,
    //   app_3: 32,
    //   app_4: 12,
    //   app_5: 22
    // };

    // const labels = Object.keys(worldPopulationGrowth);
    // const data = Object.values(worldPopulationGrowth);

    this.chart = new Chart(this.canvas, {
      type: 'bar',
      data: {
        labels: chartLabels,
        datasets: [
          {
            label: 'Users per app',
            data: chartData,
            fill: false,
            backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(255, 206, 86, 0.2)',
              'rgba(75, 192, 192, 0.2)',
              'rgba(153, 102, 255, 0.2)',
              'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: 'rgb(75, 192, 192)',
            tension: 0.1
          }
        ]
      }
    });
  }

  disconnect() {
    if (this.chart) {
      this.chart.destroy();
    }
  }
}
