import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "lever", "input"];

  connect() {
    if (this.inputTarget.value == "true") this.toggle(false);
  }

  toggle(toggleInput = true) {
    if (toggleInput)
      this.inputTarget.value =
        this.inputTarget.value == "true" ? "false" : "true";

    this.buttonTarget.classList.toggle("bg-gray-200");
    this.buttonTarget.classList.toggle("bg-emerald-500");

    this.leverTarget.classList.toggle("translate-x-0");
    this.leverTarget.classList.toggle("translate-x-5");
  }
}
