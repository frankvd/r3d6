# frozen_string_literal: true

require 'r3d6-parser/lexer'
require 'r3d6-parser/parser'

include R3D6::Parser

RSpec.describe DiceRoll, '#roll' do
  it 'rolls random dice' do 
    srand(42)
    roll = DiceRoll.new(3, 8)
    roll.roll
    expect(roll.dice).to eq([Die.new(8, 7), Die.new(8, 4), Die.new(8, 5)])
  end

  it 'applies modifiers' do 
    srand(42)
    roll = DiceRoll.new(3, 8)
    roll.modifiers << Modifiers::DropLowest.new(1)
    roll.roll
    expect(roll.dice).to eq([Die.new(8, 7), Die.new(8, 4, :dropped), Die.new(8, 5)])
  end

  it 'has a string representation' do
    roll = DiceRoll.new(3, 8)
    expect(roll.to_s).to eq("3d8")
  end
end