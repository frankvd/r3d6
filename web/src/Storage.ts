import { Roll } from "./Roll"

export class Storage {
  storage = window.localStorage

  getRolls() {
    let json = this.storage.getItem('rolls')
    if (!json) {
      return this.defaultRolls()
    }

    return this.deserialize(json)
  }

  save(rolls : Array<Roll>) {
    this.storage.setItem('rolls', this.serialize(rolls))
  }

  serialize(rolls : Array<Roll>) {
    return JSON.stringify(rolls.map((roll) => {
      return {
        title: roll.title,
        definition: roll.definition
      }
    }))
  }

  deserialize(json : any) {
    return JSON.parse(json).map((item : any) => {
      return new Roll(item.title, item.definition)
    })
  }

  defaultRolls() {
    return [
      new Roll('Shortsword + 1', '1d6 + 4 + 1'),
      new Roll('Fireball', '8d6'),
      new Roll('Dagger sneak attack', '1d4 + 3d6 + 4'),
      new Roll('Roll stat', '4d6d1')
    ]
  }
}
