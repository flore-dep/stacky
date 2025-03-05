import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
  static targets = ["dashboard", "myApps", "dashboardButton", "myAppsButton"]

  connect() {
    console.log("Fleur Imichon");
  }

  viewDashboard() {
    this.myAppsButtonTarget.classList.remove("green-button-visible");
    this.myAppsButtonTarget.classList.add("green-button-disable");
    this.myAppsTarget.classList.add("d-none");
    this.dashboardTarget.classList.remove("d-none");
    this.dashboardButtonTarget.classList.add("gray-button-active");
  }

  viewApps() {
    this.dashboardButtonTarget.classList.remove("gray-button-active");
    this.dashboardTarget.classList.add("d-none");
    this.myAppsButtonTarget.classList.remove("green-button-disable");
    this.myAppsButtonTarget.classList.add("green-button-visible");
    this.myAppsTarget.classList.remove("d-none");
  }
}
