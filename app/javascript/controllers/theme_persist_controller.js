import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { key: String }

  connect() {
    const key = this.keyValue || "theme"
    const saved = localStorage.getItem(key)

    if (saved) {
      document.documentElement.setAttribute("data-theme", saved)
      const radio = this.element.querySelector(
        `input.theme-controller[value="${saved}"]`
      )
      if (radio) radio.checked = true
    }
  }

  save(event) {
    const key = this.keyValue || "theme"
    const theme = event.currentTarget.value
    localStorage.setItem(key, theme)
    document.documentElement.setAttribute("data-theme", theme)
  }
}