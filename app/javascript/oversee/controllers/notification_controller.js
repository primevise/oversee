import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.classList.remove("opacity-0");
    }, 100);

    setTimeout(() => {
      this.element.classList.remove("opacity-100");
      this.element.classList.add("opacity-0");
    }, 2500);
    setTimeout(() => {
      this.element.outerHTML = "";
    }, 3000);
  }
}
