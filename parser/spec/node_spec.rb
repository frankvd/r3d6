# frozen_string_literal: true

require 'r3d6-parser/lexer'
require 'r3d6-parser/parser'

include R3D6::Parser

RSpec.describe Node, '#echo' do
  it 'describes the evaluation' do
    node = Nodes::BinaryExpression.new('+', Nodes::Integer.new(4), Nodes::Variable.new(Variable.new('STR')))
    node.evaluate({ 'STR' => 5 })
    expect(node.echo).to eq('4 + [5]')
  end
end

RSpec.describe Node, '#evaluate' do
  it 'can evaluate an AST' do
    roll = DiceRoll.new(3, 6)
    roll.modifiers << Modifiers::DropLowest.new(1)

    srand(42)

    ast = Nodes::BinaryExpression.new('-',
                                      Nodes::BinaryExpression.new('+',
                                                                  Nodes::DiceRoll.new(roll),
                                                                  Nodes::Variable.new(Variable.new('STR'))),
                                      Nodes::Integer.new(3))

    expect(ast.evaluate('STR' => -2)).to eq(4)
  end
end
