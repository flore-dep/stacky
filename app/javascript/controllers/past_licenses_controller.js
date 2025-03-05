import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="past-licenses"
export default class extends Controller {
  static targets = ["pastlicenses", "activelicenses"]

  connect() {
    console.log("hey");
  }

  viewpast() {
    this.activelicensesTarget.classList.add("d-none");
    this.pastlicensesTarget.classList.remove("d-none");
  }

  viewactive() {
    this.activelicensesTarget.classList.remove("d-none");
    this.pastlicensesTarget.classList.add("d-none");
  }
}
