# frozen_string_literal: true

require 'r3d6-parser/lexer'
require 'r3d6-parser/parser'

include R3D6::Parser

RSpec.describe Lexer, '#tokenize' do
  it 'Supports dice rolls' do
    text = '3d6'

    lexer = Lexer.new
    expect(lexer.tokenize(text)).to eq([Token.new(Token::DICE, '3d6')])
  end

  it 'Supports the drop lowest dice roll modifier' do
    text = '3d6d1'

    lexer = Lexer.new
    expect(lexer.tokenize(text)).to eq([Token.new(Token::DICE, '3d6'), Token.new(Token::DICE_ROLL_MODIFIER, 'd1')])
  end

  it 'Supports numbers' do
    text = '42'

    lexer = Lexer.new
    expect(lexer.tokenize(text)).to eq([Token.new(Token::NUMBER, '42')])
  end

  it 'Supports the + operator' do
    text = '+'

    lexer = Lexer.new
    expect(lexer.tokenize(text)).to eq([Token.new(Token::OPERATOR, '+')])
  end

  it 'Supports the - operator' do
    text = '-'

    lexer = Lexer.new
    expect(lexer.tokenize(text)).to eq([Token.new(Token::OPERATOR, '-')])
  end

  it 'Tokenizes text into an array of tokens' do
    text = '2d8+3d6d1+4-1'

    expected = [
      Token.new(Token::DICE, '2d8'),
      Token.new(Token::OPERATOR, '+'),
      Token.new(Token::DICE, '3d6'),
      Token.new(Token::DICE_ROLL_MODIFIER, 'd1'),
      Token.new(Token::OPERATOR, '+'),
      Token.new(Token::NUMBER, '4'),
      Token.new(Token::OPERATOR, '-'),
      Token.new(Token::NUMBER, '1')
    ]

    lexer = Lexer.new
    expect(lexer.tokenize(text)).to eq(expected)
  end

  it 'Ignores whitespace' do
    text = "3d6 + 4\t- 1"

    expected = [
      Token.new(Token::DICE, '3d6'),
      Token.new(Token::OPERATOR, '+'),
      Token.new(Token::NUMBER, '4'),
      Token.new(Token::OPERATOR, '-'),
      Token.new(Token::NUMBER, '1')
    ]

    lexer = Lexer.new
    expect(lexer.tokenize(text)).to eq(expected)
  end
end
