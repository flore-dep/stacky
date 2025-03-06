import { Controller } from "@hotwired/stimulus"
import { Chart } from "chart.js";

// Connects to data-controller="chart"
export default class extends Controller {
  connect() {
    console.log("hello from line");
    const worldPopulationGrowth = {
      2020: 7794798739,
      2019: 7811293698,
      2018: 7729902781,
      2017: 7645617954,
      2016: 7558554526,
      2015: 7470491872,
      2014: 7381616244,
      2013: 7291793585,
      2012: 7201202485,
      2011: 7110923765,
      2010: 7021732148
    };

    const labels = Object.keys(worldPopulationGrowth);
    const data = Object.values(worldPopulationGrowth);

    this.chart = new Chart(this.element, {
      type: 'line',
      data: {
        labels,
        datasets: [{
          label: 'World population growth',
          data,
          backgroundColor: [
            'rgb(255, 99, 132)',
          ],
          hoverOffset: 4
        }]
      }
    });
  }
}
