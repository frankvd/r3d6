# frozen_string_literal: true

require 'r3d6-parser/token'

module R3D6
  module Parser
    class Lexer
      def initialize
        @output = []
        @current = nil
      end

      def tokenize(input)
        @output = []
        @current = Token.new
        input.each_char do |char|
          next_char char
        end
        append unless @current.type == Token::UNKNOWN

        @output
      end

      def next_char(char)
        if digit?(char)
          read_digit char
        elsif char == 'd'
          read_d char
        elsif operator?(char)
          read_operator char
        elsif whitespace?(char)
          nil
        else
          raise 'Unexpected input'
        end
      end

      def read_digit(char)
        @current.value = @current.value + char
        @current.type = Token::NUMBER if @current.type == Token::UNKNOWN
      end

      def read_d(char)
        if [Token::DICE, Token::DICE_ROLL_MODIFIER].include? @current.type
          append
          @current.type = Token::DICE_ROLL_MODIFIER
          @current.value = @current.value + char
        elsif [Token::NUMBER, Token::UNKNOWN].include? @current.type
          @current.value = @current.value + char
          @current.type = Token::DICE
        end
      end

      def read_operator(char)
        append unless @current.type == Token::UNKNOWN
        token = Token.new
        token.type = Token::OPERATOR
        token.value = char
        @output << token
      end

      def append
        @output << @current
        @current = Token.new
      end

      def digit?(char)
        %w[0 1 2 3 4 5 6 7 8 9].include? char
      end

      def operator?(char)
        ['+', '-'].include? char
      end

      def whitespace?(char)
        [' ', "\t"].include? char
      end
    end
  end
end
