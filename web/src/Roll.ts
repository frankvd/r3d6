import { LitElement, property, html, css } from "lit-element"
import Config from "./Config"

export class Roll extends LitElement {
  @property({type: String}) definition = ''
  @property({type: String}) output = ''

  static get styles() {
    return css`
      .roll-container {
        display: grid;
        grid-template-columns: auto 80px;
        grid-template-rows: 40px 40px;
        grid-auto-flow: column;
        background: #111;
      }

      .roll-button {
        background: #111;
        color: var(--fg);
        border: 0;
        border-left: 1px solid var(--fg);
        border-radius: 0;
        height: 100%;
        width: 100%;
        text-align: center;
        grid-row-start: 1;
        grid-row-end: 3;
        outline: none;
        cursor: pointer;
      }

      .roll-input {
        background: var(--fg);
        border: 0;
        border-radius: 0;
        outline: none;
      }

      .roll-output {
        line-height: 40px;
        padding: 0 6px;
      }
      .roll-output::before {
        content: "> "
      }
    `
  }

  render() {
    return html`
      <div class="roll-container">
        <input class="roll-input" value="${this.definition}" @change=${(e:any) => {this.definition = e.target.value;console.log(e)}} />
        <div class="roll-output">${this.output}</div>
        <button class="roll-button" @click="${this.roll}">Roll</button>
      </div>
    `
  }

  roll() {
    fetch(Config.APIBaseURL + this.definition).then(async response => {
      this.output = await response.text()
    })
  }
}
