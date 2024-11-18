import { Controller } from "@hotwired/stimulus";

const KEY_BASE = "oversee-sidebar";

export default class extends Controller {
  initialize() {
    this.key = `${KEY_BASE}--${this.element.id}`;
    this.expanded = localStorage.getItem(this.key) === "true";
    this.element.open = this.expanded;
  }

  toggle() {
    this.expanded = !this.expanded;
    this.element.open = this.expanded;
  }

  persist(event) {
    this.expanded = event.newState === "open";
    localStorage.setItem(this.key, this.expanded);
  }
}
