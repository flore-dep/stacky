import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="past-licenses"
export default class extends Controller {
  static targets = ["pastlicenses", "activelicenses", "pastbutton", "activebutton"]

  connect() {
    console.log("hey");
  }

  viewpast() {
    this.activebuttonTarget.classList.remove("green-button-visible");
    this.activebuttonTarget.classList.add("black-button-disable");
    this.activelicensesTarget.classList.add("d-none");
    this.pastbuttonTarget.classList.add("black-button-disable");
    this.pastbuttonTarget.classList.add("green-button-visible");
    this.pastlicensesTarget.classList.remove("d-none");
  }

  viewactive() {
    this.pastbuttonTarget.classList.remove("green-button-visible");
    this.pastbuttonTarget.classList.add("black-button-disable")
    this.pastlicensesTarget.classList.add("d-none");
    this.activebuttonTarget.classList.remove("black-button-disable");
    this.activebuttonTarget.classList.add("green-button-visible");
    this.activelicensesTarget.classList.remove("d-none");
  }
}
