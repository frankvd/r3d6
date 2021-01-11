import { LitElement, property, html } from "lit-element"
import Config from "./Config"

export class Roll extends LitElement {
  @property({type: String}) definition = ''
  @property({type: String}) output = ''

  render() {
    return html`
      <div>
        <input value="${this.definition}" @change=${(e:any) => {this.definition = e.target.value;console.log(e)}} />
        <button @click="${this.roll}">Roll</button>
        <span>${this.output}</span>
      </div>
    `
  }

  roll() {
    fetch(Config.APIBaseURL + this.definition).then(async response => {
      this.output = await response.text()
    })
  }
}
