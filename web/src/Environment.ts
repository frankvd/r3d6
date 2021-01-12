import { html, LitElement, property, queryAssignedNodes } from "lit-element"

export class Environment extends LitElement {
  @queryAssignedNodes('roll', true) rolls!: NodeListOf<HTMLElement>

  render() {
    return html`
      <div>
        <slot name="roll"></slot>
      </div>
    `
  }
}
