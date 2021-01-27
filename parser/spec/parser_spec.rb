# frozen_string_literal: true

require 'r3d6-parser/lexer'
require 'r3d6-parser/parser'

include R3D6::Parser

RSpec.describe R3D6::Parser::Parser, '#parse' do
  it 'Creates an AST from an array of tokens' do
    tokens = [
      Token.number('3'),
      Token.operator('+'),
      Token.dice('3d6'),
      Token.modifier('d1'),
      Token.operator('-'),
      Token.variable('STR')
    ]

    parser = Parser.new
    ast = parser.parse tokens

    roll = DiceRoll.new(3, 6)
    roll.modifiers << Modifiers::DropLowest.new(1)

    expect(ast).to eq(
      Nodes::BinaryExpression.new('+',
        Nodes::Integer.new(3),
        Nodes::BinaryExpression.new('-',
          Nodes::DiceRoll.new(roll),
          Nodes::Variable.new('STR'))
      )
    )
  end
end
