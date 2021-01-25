import { LitElement, property, html, css } from "lit-element"
import Config from "./Config"

export class Roll extends LitElement {
  @property({type: String}) title = ''
  @property({type: String}) definition = ''
  @property({type: String}) output = ''

  readonly STATE_DEFAULT = 'roll-state-default'
  readonly STATE_EDIT = 'roll-state-edit'
  @property({type: String}) state = this.STATE_DEFAULT

  readonly MENU_STATE_OPEN = 'roll-menu-opened'
  readonly MENU_STATE_CLOSED = 'roll-menu-closed'
  @property({type: String}) menu_state = this.MENU_STATE_CLOSED

  constructor(title = '', definition = '', output = '... ... ... ... ... ... ... ... ... ... ... ...') {
    super()
    this.title = title
    this.definition = definition
    this.output = output
  }

  static get styles() {
    return css`
      .roll-container {
        position: relative;
        background: #fff;
        margin: 24px 0;
        border-radius: 30px;
        box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
        overflow: auto;
        width: 420px;
        box-sizing: border-box;
      }

      .roll-container.roll-state-edit {
        padding-top: 22px;
      }

      .roll-title {
        margin: 30px 0 0 20px;
        font-family: Roboto Slab;
        font-style: normal;
        font-weight: normal;
        font-size: 24px;
        line-height: 32px;
        color: #000000;
      }
      .roll-menu {
        position: absolute;
        right: 20px;
        top: 20px;
        background: #fff;
        box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
        transition: opacity 0.5s ease, margin 0.5s ease;
      }
      .roll-menu-item {
        padding: 10px 20px;
        cursor: pointer;
      }
      .roll-menu-item:hover {
        background: #f3f3f3;
      }

      .roll-menu-opened {
        margin-top: 0;
        opacity: 1;
      }
      .roll-menu-closed {
        margin-top: -10px;
        z-index: -1;
        opacity: 0;
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
        color: #000;
        float:right;
        text-decoration: none;
        margin: 20px 40px 20px 0;
        cursor: pointer;
        user-select: none;
      }

      .roll-definition {
        margin: 20px 0 0 20px;
        font-size: 24px;
        line-height: 28px;
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

      label, input {
        display: block;
      }

      label {
        margin: 10px 0 0 20px;
        font-size: 12px;
        line-height: 14px;
        color: #888888;
      }

      input {
        width: 355px;
        font-size: 24px;
        line-height: 28px;
        margin: 4px 0 0 20px;
        background: #F3F3F3;
        padding: 4px 12px;
        border-radius: 4px;
        border: 0;
        outline: none;
      }
    `
  }

  render() {
    if (this.state == this.STATE_DEFAULT) {
      return this.renderDefault()
    } else {
      return this.renderEdit()
    }
  }

  renderDefault() {
    return html`
      <div class="roll-container ${this.state}">
        <div class="roll-menu ${this.menu_state}">
          <div class="roll-menu-item" @click="${this.edit}">Edit</div>
          <div class="roll-menu-item" @click="${this.triggerRemoval}">Remove</div>
        </div>
        <div class="roll-menu-button" @click="${this.openMenu}">&#x2B24;&#x2B24;&#x2B24;</div>
        <div class="roll-title">${this.title}</div>
        <div class="roll-definition">${this.definition}</div>
        <div class="roll-output">${this.output}</div>
        <a class="roll-button" @click="${this.roll}">Roll</a>
      </div>
    `

    //  <input class="roll-input" value="${this.definition}" @change=${(e:any) => {this.definition = e.target.value;}} />
  }

  renderEdit() {
    return html`
      <div class="roll-container ${this.state}">
        <label>Title</label>
        <input class="roll-input" value="${this.title}" @change=${(e:any) => {this.title = e.target.value;}} />
        <label>Definition</label>
        <input class="roll-input" value="${this.definition}" @change=${(e:any) => {this.definition = e.target.value;}} />
        <a class="roll-button" @click="${this.save}">Save</a>
      </div>
    `
  }

  openMenu() {
    this.menu_state = this.MENU_STATE_OPEN
    setTimeout(() => document.addEventListener('click', () => this.closeMenu(), {once: true}))
  }

  closeMenu() {
    this.menu_state = this.MENU_STATE_CLOSED
  }

  save() {
    this.state = this.STATE_DEFAULT
  }

  edit() {
    this.state = this.STATE_EDIT
  }

  triggerRemoval() {
    this.dispatchEvent(new CustomEvent('remove-roll', {detail: {roll: this}, bubbles: true}))
  }

  roll() {
    fetch(Config.APIBaseURL + this.definition).then(async response => {
      this.output = await response.text()
    })
  }
}
