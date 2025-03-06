import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar-toggler"
export default class extends Controller {

  static targets = ["toggle", "userLi", "ownerLi"]

  connect() {
    var label = this.toggleTarget.querySelector('label').innerText
    if (label === "owner") {
      this.userLiTargets.forEach(li => li.classList.add("d-none"))
    } else {
      this.ownerLiTargets.forEach(li => li.classList.add("d-none"))
    }
  };

  switch() {
    if (this.toggleTarget.querySelector('input').checked) {
      window.location.href = "/my_softwares"
    } else {
      window.location.href = "/softwares"
    };
  };
}
