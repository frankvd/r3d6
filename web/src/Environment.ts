import { css, html, LitElement, property, queryAssignedNodes } from "lit-element"
import { Roll } from "./Roll"
import { Storage } from "./Storage"

export class Environment extends LitElement {
  @property({attribute: false})
  rolls:Array<Roll> = []
  storage = new Storage()

  constructor() {
    super()
    this.rolls = this.storage.getRolls()
  }

  static get styles() {
    return css`
      .roll-add {
        width: 80px;
        height: 80px;
        border-radius: 40px;
        background: #fdfdfd;
        box-shadow: 0px 3px 3px rgba(0, 0, 0, 0.25);
        font-size: 48px;
        line-height: 80px;
        font-weight: 300;
        text-align: center;
        margin: 40px auto;
        cursor: pointer;
        transition: box-shadow .5s;
      }

      .roll-add:hover {
        box-shadow: 0px 6px 6px rgba(0, 0, 0, 0.25);
      }
    `
  }

  render() {
    return html`
      <div>
        <div @remove-roll=${this.removeRoll} id="rolls">
          ${this.rolls}
        </div>
        <div>
          <div class="roll-add" @click="${this.add}">+</div>
        </div>
      </div>
    `
  }

  updated(changed : Map<string, any>) {
    console.log(changed)
    this.storage.save(this.rolls)
  }

  add() {
    let roll = new Roll
    roll.title = "New"
    roll.definition = "1d20"
    roll.state = roll.STATE_EDIT
    this.rolls = [...this.rolls, roll]
  }

  removeRoll(e : CustomEvent) {
    this.rolls = this.rolls.filter((roll) =>  {
      return roll !== e.detail.roll
    })
  }
}
