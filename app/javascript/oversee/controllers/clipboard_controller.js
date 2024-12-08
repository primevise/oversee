import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { content: String };

  connect() {
    console.log("Hello from clipboard_controller.js");
  }

  copy() {
    navigator.clipboard
      .writeText(this.contentValue)
      .then(() => console.log("Copied to clipboard"));
  }
}
