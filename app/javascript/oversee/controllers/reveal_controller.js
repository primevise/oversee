import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["revealable"];
  static values = { revealableId: String };

  connect() {
    if (this.hasRevealableIdValue)
      this.target = document.getElementById(this.revealableIdValue);

    if (!this.target && this.hasRevealableTarget)
      this.target = this.revealableTarget;
  }

  toggle() {
    console.log("Toggling");
    if (!this.target) return;
    this.target.classList.toggle("hidden");
  }
}
