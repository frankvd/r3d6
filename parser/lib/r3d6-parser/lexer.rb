# frozen_string_literal: true

require 'r3d6-parser/token'

module R3D6
  module Parser
    class Lexer
      def initialize
        @output = []
        @current = nil
        @input = []
        @index = 0
      end

      def tokenize(input)
        @output = []
        @current = Token.new
        @index = 0
        @input = input.chars
        while @index < input.size
          next_char input[@index]
          @index += 1
        end
        append unless @current.type == Token::UNKNOWN

        @output
      end

      def next_char(char)
        if digit?(char)
          read_digit char
        elsif char == 'd'
          read_d char
        elsif char == 'k'
          read_modifier char
        elsif operator?(char)
          read_operator char
        elsif variable?(char)
          read_variable char
        elsif whitespace?(char)
          nil
        elsif parenthesis?(char)
          read_parenthesis(char)
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
          read_modifier char
        elsif [Token::NUMBER, Token::UNKNOWN].include? @current.type
          @current.value = @current.value + char
          @current.type = Token::DICE
        end
      end

      def read_modifier(char)
        append
        @current.type = Token::DICE_ROLL_MODIFIER
        @current.value = @current.value + char
      end

      def read_operator(char)
        append unless @current.type == Token::UNKNOWN
        token = Token.new
        token.type = Token::OPERATOR
        token.value = char
        @output << token
      end

      def read_parenthesis(char)
        append unless @current.type == Token::UNKNOWN
        token = Token.new
        token.type = char == '(' ? Token::OPEN_PARENTHESIS : Token::CLOSE_PARENHESIS
        token.value = char
        @output << token
      end

      def read_variable(char)
        identifier = ''

        (1...(@input.size - @index)).each do |_i|
          @index += 1
          char = @input[@index]
          break if char == ']'

          identifier += char
        end

        raise 'Invalid variable' if char != ']'

        @current.type = Token::VARIABLE
        @current.value = identifier
        append
      end

      def append
        @output << @current
        @current = Token.new
      end

      def digit?(char)
        %w[0 1 2 3 4 5 6 7 8 9].include? char
      end

      def operator?(char)
        ['+', '-', '*', '/'].include? char
      end

      def variable?(char)
        char == '['
      end

      def whitespace?(char)
        [' ', "\t"].include? char
      end

      def parenthesis?(char)
        ['(', ')'].include? char
      end
    end
  end
end
