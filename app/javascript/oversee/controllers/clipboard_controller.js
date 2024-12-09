import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["copyIcon", "successIcon"];
  static values = { content: String };

  connect() {
    console.log("Copy icon", this.copyIconTarget);
    console.log("Success icon", this.successIconTarget);
  }

  async copy() {
    try {
      await navigator.clipboard.writeText(this.contentValue);
      this.toggleIcons(true);
      setTimeout(() => this.toggleIcons(false), 1500);
    } catch (error) {
      console.error(error.message);
    }
  }

  toggleIcons(isCopied) {
    this.copyIconTarget.classList.toggle("hidden", isCopied);
    this.successIconTarget.classList.toggle("hidden", !isCopied);
  }
}
