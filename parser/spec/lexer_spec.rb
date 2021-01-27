# frozen_string_literal: true

require 'r3d6-parser/lexer'
require 'r3d6-parser/parser'

include R3D6::Parser

RSpec.describe Lexer, '#tokenize' do
  it 'supports dice rolls' do
    text = '3d6'

    lexer = Lexer.new
    expect(lexer.tokenize(text)).to eq([Token.new(Token::DICE, '3d6')])
  end

  it 'supports the drop lowest dice roll modifier' do
    text = '3d6d1'

    lexer = Lexer.new
    expect(lexer.tokenize(text)).to eq([Token.new(Token::DICE, '3d6'), Token.new(Token::DICE_ROLL_MODIFIER, 'd1')])
  end

  it 'supports numbers' do
    text = '42'

    lexer = Lexer.new
    expect(lexer.tokenize(text)).to eq([Token.new(Token::NUMBER, '42')])
  end

  it 'supports the + operator' do
    text = '+'

    lexer = Lexer.new
    expect(lexer.tokenize(text)).to eq([Token.new(Token::OPERATOR, '+')])
  end

  it 'supports the - operator' do
    text = '-'

    lexer = Lexer.new
    expect(lexer.tokenize(text)).to eq([Token.new(Token::OPERATOR, '-')])
  end

  it 'supports variables' do
    text = '[STR]'

    lexer = Lexer.new
    expect(lexer.tokenize(text)).to eq([Token.new(Token::VARIABLE, 'STR')])
  end

  it 'tokenizes text into an array of tokens' do
    text = '2d8+3d6d1+[STR]-1'

    expected = [
      Token.new(Token::DICE, '2d8'),
      Token.new(Token::OPERATOR, '+'),
      Token.new(Token::DICE, '3d6'),
      Token.new(Token::DICE_ROLL_MODIFIER, 'd1'),
      Token.new(Token::OPERATOR, '+'),
      Token.new(Token::VARIABLE, 'STR'),
      Token.new(Token::OPERATOR, '-'),
      Token.new(Token::NUMBER, '1')
    ]

    lexer = Lexer.new
    expect(lexer.tokenize(text)).to eq(expected)
  end

  it 'ignores whitespace' do
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

  it "errors on unexpected input" do
    text = "3d6 + hunter2"

    lexer = Lexer.new
    expect { lexer.tokenize(text) }.to raise_error("Unexpected input")
  end
end
