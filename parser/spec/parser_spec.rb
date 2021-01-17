# frozen_string_literal: true

require 'r3d6-parser/lexer'
require 'r3d6-parser/parser'

include R3D6::Parser

RSpec.describe R3D6::Parser::Parser, '#parse' do
  it 'Sums the output' do
    srand(42)
    test = '3d12+4'
    tokenizer = R3D6::Parser::Lexer.new
    tokens = tokenizer.tokenize(test)
    parser = R3D6::Parser::Parser.new
    ast = parser.parse tokens
    out = ast.evaluate

    expect(out).to eq(7 + 4 + 11 + 4)
  end

  it 'Creates an AST from an array of tokens' do
    tokens = [
      Token.new(Token::DICE, '3d6'),
      Token.new(Token::DICE_ROLL_MODIFIER, 'd1'),
      Token.new(Token::OPERATOR, '+'),
      Token.new(Token::NUMBER, '4')
    ]

    parser = Parser.new
    ast = parser.parse tokens

    roll = DiceRoll.new(3, 6)
    roll.modifiers << Modifiers::DropLowest.new(1)

    expect(ast).to eq(
      Nodes::BinaryExpression.new('+',
                                  Nodes::DiceRoll.new(roll),
                                  Nodes::Integer.new(4))
    )
  end
end
