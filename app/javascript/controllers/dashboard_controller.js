import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
  static targets = ["dashboard", "myApps", "dashboardButton", "myAppsButton"]

  connect() {
    console.log("Flore Imichon");
  }

  viewDashboard() {
    this.myAppsButtonTarget.classList.remove("green-button-visible");
    this.myAppsButtonTarget.classList.add("black-button-disable");
    this.myAppsTarget.classList.add("d-none");
    this.dashboardButtonTarget.classList.remove("black-button-disable");
    this.dashboardButtonTarget.classList.add("green-button-visible")
    this.dashboardTarget.classList.remove("d-none");

  }

  viewApps() {
    this.dashboardButtonTarget.classList.remove("green-button-visible")
    this.dashboardButtonTarget.classList.add("black-button-disable");
    this.dashboardTarget.classList.add("d-none");
    this.myAppsButtonTarget.classList.remove("black-button-disable");
    this.myAppsButtonTarget.classList.add("green-button-visible");
    this.myAppsTarget.classList.remove("d-none");

  }
}
