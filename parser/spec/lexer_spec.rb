require 'r3d6-parser/lexer'
require 'r3d6-parser/parser'

include R3D6::Parser

RSpec.describe R3D6::Parser::Lexer, "#tokenize"  do
    it "Supports dice rolls" do
        text = "3d6"

        lexer = Parser::Lexer.new
        expect(lexer.tokenize(text)).to eq([Token.new(Token::Dice, "3d6")])
    end
    it "Supports numbers" do
        text = "42"

        lexer = Lexer.new
        expect(lexer.tokenize(text)).to eq([Token.new(Token::Number, "42")])
    end

    it "Supports the + operator" do
        text = "+"

        lexer = Lexer.new
        expect(lexer.tokenize(text)).to eq([Token.new(Token::Operator, "+")])
    end

    it "Supports the - operator" do
        text = "-"

        lexer = Lexer.new
        expect(lexer.tokenize(text)).to eq([Token.new(Token::Operator, "-")])
    end

    it "Tokenizes text into an array of tokens" do
        text = "2d8+3d6+4-1"

        expected = [
            Token.new(Token::Dice, "2d8"),
            Token.new(Token::Operator, "+"),
            Token.new(Token::Dice, "3d6"),
            Token.new(Token::Operator, "+"),
            Token.new(Token::Number, "4"),
            Token.new(Token::Operator, "-"),
            Token.new(Token::Number, "1")
        ]

        lexer = Lexer.new
        expect(lexer.tokenize(text)).to eq(expected)
    end
    
    it "Ignores whitespace" do
        text = "3d6 + 4\t- 1"

        expected = [
            Token.new(Token::Dice, "3d6"),
            Token.new(Token::Operator, "+"),
            Token.new(Token::Number, "4"),
            Token.new(Token::Operator, "-"),
            Token.new(Token::Number, "1")
        ]

        lexer = Lexer.new
        expect(lexer.tokenize(text)).to eq(expected)
    end
end