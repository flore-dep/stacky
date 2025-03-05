import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
  connect() {
    console.log("Fleur Imichon");
  }

  viewDashboard() {
    this.activebuttonTarget.classList.remove("green-button-visible");
    this.activebuttonTarget.classList.add("green-button-disable");
    this.activelicensesTarget.classList.add("d-none");
    this.pastlicensesTarget.classList.remove("d-none");
    this.pastbuttonTarget.classList.add("gray-button-active");
  }

  viewApps() {
    this.pastbuttonTarget.classList.remove("gray-button-active");
    this.pastlicensesTarget.classList.add("d-none");
    this.activebuttonTarget.classList.remove("green-button-disable");
    this.activebuttonTarget.classList.add("green-button-visible");
    this.activelicensesTarget.classList.remove("d-none");
  }
}
