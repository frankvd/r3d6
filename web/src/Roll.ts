import { LitElement, property, html, css } from "lit-element"
import Config from "./Config"

export class Roll extends LitElement {
  @property({type: String}) title = ''
  @property({type: String}) definition = ''
  @property({type: String}) output = '... ... ... ... ... ... ... ... ... ... ... ...'

  static get styles() {
    return css`
      .roll-container {
        background: #fff;
        margin: 24px 0;
        border-radius: 30px;
        box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
        overflow: auto;
        width: 420px;
        box-sizing: border-box;
      }

      .roll-title {
        margin: 20px 0 0 20px;
        font-family: Roboto Slab;
        font-style: normal;
        font-weight: normal;
        font-size: 24px;
        line-height: 32px;
        color: #000000;
      }
      .roll-menu-button {
        float: right;
        font-size: 5px;
        padding: 24px;
        letter-spacing: 2px;
        cursor: pointer;
      }
      .roll-button {
        font-size: 18px;
        line-height: 21px;
        text-transform: uppercase;
        font-feature-settings: 'cpsp' on;
        color: #000;
        float:right;
        text-decoration: none;
        margin: 20px 40px 20px 0;
        cursor: pointer;
      }

      .roll-definition {
        margin: 20px 0 0 20px;
        font-size: 24px;
        line-height: 28px;
      }

      .roll-input {
        background: var(--bg);
        border: 0;
        border-radius: 0;
        outline: none;
      }

      .roll-output {
        margin: 12px 0 0 20px;
        background: #000000;
        padding: 6px;
        clip-path: polygon(6px 0%, calc(100% - 6px) 0%, 100% 6px, 100% calc(100% - 6px), calc(100% - 6px) 100%, 6px 100%, 0% calc(100% - 6px), 0% 6px);
        font-family: Roboto Mono;
        font-style: normal;
        font-weight: bold;
        font-size: 14px;
        box-sizing: border-box;
        height: 30px;
        color: #fff;
        width: 380px;
      }
    `
  }

  render() {
    return html`
      <div class="roll-container">
        <div class="roll-menu-button">&#x2B24;&#x2B24;&#x2B24;</div>
        <div class="roll-title">Shortsword +1</div>
        <div class="roll-definition">${this.definition}</div>
        <div class="roll-output">${this.output}</div>
        <a class="roll-button" @click="${this.roll}">Roll</a>
      </div>
    `

    //  <input class="roll-input" value="${this.definition}" @change=${(e:any) => {this.definition = e.target.value;}} />
  }

  roll() {
    fetch(Config.APIBaseURL + this.definition).then(async response => {
      this.output = await response.text()
    })
  }
}
