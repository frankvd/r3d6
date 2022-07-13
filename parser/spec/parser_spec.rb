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
      Token.open,
      Token.variable('STR'),
      Token.close
    ]

    parser = Parser.new
    ast = parser.parse tokens

    roll = DiceRoll.new(3, 6)
    roll.modifiers << Modifiers::DropLowest.new(1)

    expect(ast).to eq(
      Nodes::BinaryExpression.new(
        '-',
        Nodes::BinaryExpression.new(
          '+',
          Nodes::Integer.new(3),
          Nodes::DiceRoll.new(roll),
        ),
        Nodes::Variable.new(Variable.new('STR'))
      )
    )

    ast.evaluate({ 'STR' => -2 })

    expect(Token.print(tokens)).to eq("3 + (5 + 5 + 2\u0335) - ([-2])")
  end
end
