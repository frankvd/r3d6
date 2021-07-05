# frozen_string_literal: true

require 'r3d6-parser/lexer'
require 'r3d6-parser/parser'

Nodes = R3D6::Parser::Nodes 

RSpec.describe Nodes::BinaryExpression, '#evaluate' do
  it 'can add two integers' do
    expression = Nodes::BinaryExpression.new('+', Nodes::Integer.new(3), Nodes::Integer.new(4))

    expect(expression.evaluate).to eq(7)
  end

  it 'can substract two integers' do
    expression = Nodes::BinaryExpression.new('-', Nodes::Integer.new(3), Nodes::Integer.new(4))

    expect(expression.evaluate).to eq(-1)
  end

  it 'can add a dice roll and a integer' do
    int_node = Nodes::Integer.new(3)
    dice_node = Nodes::DiceRoll.new(DiceRoll.new(3, 6))
    expression_a = Nodes::BinaryExpression.new('+', int_node, dice_node)
    expression_b = Nodes::BinaryExpression.new('+', dice_node, int_node)
    srand(42)
    expect(expression_a.evaluate).to eq(15)
    srand(42)
    expect(expression_b.evaluate).to eq(15)
  end

  it 'can substract an integer from a dice roll' do
    int_node = Nodes::Integer.new(4)
    dice_node = Nodes::DiceRoll.new(DiceRoll.new(3, 6))
    expression_a = Nodes::BinaryExpression.new('-', dice_node, int_node)
    expression_b = Nodes::BinaryExpression.new('-', int_node, dice_node)

    srand(42)
    expect(expression_a.evaluate).to eq(8)
    srand(42)
    expect(expression_b.evaluate).to eq(-8)
  end
end
