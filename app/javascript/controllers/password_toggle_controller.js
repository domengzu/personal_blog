import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="password-toggle"
export default class extends Controller {
  static targets = ["input", "eye", "eyeSlash"];

  connect() {
  }

  toggle() {
    const isPassword = this.inputTarget.type === "password";
    this.inputTarget.type = isPassword ? "text" : "password";

    this.eyeTarget.classList.toggle("hidden", isPassword);
    this.eyeSlashTarget.classList.toggle("hidden", !isPassword);
  }
}
