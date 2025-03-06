import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="past-licenses"
export default class extends Controller {
  static targets = ["pastlicenses", "activelicenses", "pastbutton", "activebutton"]

  connect() {
    console.log("hey");
  }

  viewpast() {
    this.activebuttonTarget.classList.remove("green-button-visible");
    this.activebuttonTarget.classList.add("green-button-disable");
    this.activelicensesTarget.classList.add("d-none");
    this.pastlicensesTarget.classList.remove("d-none");
    this.pastbuttonTarget.classList.add("gray-button-active");
  }

  viewactive() {
    this.pastbuttonTarget.classList.remove("gray-button-active");
    this.pastlicensesTarget.classList.add("d-none");
    this.activebuttonTarget.classList.remove("green-button-disable");
    this.activebuttonTarget.classList.add("green-button-visible");
    this.activelicensesTarget.classList.remove("d-none");
  }
}
