import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

export default class extends Controller {
  connect() {
    this.canvas = document.createElement("canvas");
    this.element.appendChild(this.canvas);
    var chartData = this.element.getAttribute('data-chart-data').split(",").map(Number);
    var chartLabels = this.element.getAttribute('data-chart-labels').split(",");

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
