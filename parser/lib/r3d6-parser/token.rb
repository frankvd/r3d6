# frozen_string_literal: true

module R3D6
  module Parser
    class Token
      UNKNOWN = 0
      NUMBER = 1
      DICE = 2
      DICE_ROLL_MODIFIER = 3
      OPERATOR = 4
      VARIABLE = 5
      OPEN_PARENTHESIS = 6
      CLOSE_PARENHESIS = 7

      attr_accessor :type, :value, :printer

      def initialize(type = Token::UNKNOWN, value = '')
        @type = type
        @value = value
        @printer = ->(v) { v.to_s }
      end

      def left_parenthesis?
        @type == OPEN_PARENTHESIS
      end

      def right_parenthesis?
        @type == CLOSE_PARENHESIS
      end

      def self.dice(value)
        Token.new Token::DICE, value
      end

      def self.number(value)
        Token.new Token::NUMBER, value
      end

      def self.modifier(value)
        Token.new Token::DICE_ROLL_MODIFIER, value
      end

      def self.operator(value)
        Token.new Token::OPERATOR, value
      end

      def self.variable(value)
        Token.new Token::VARIABLE, value
      end

      def self.open
        Token.new Token::OPEN_PARENTHESIS, '('
      end

      def self.close
        Token.new Token::CLOSE_PARENHESIS, ')'
      end

      def print
        @printer.call(value)
      end

      def modifier?
        @type == DICE_ROLL_MODIFIER
      end

      def self.print(tokens)
        str = ''
        without_modifiers = tokens.reject(&:modifier?)
        without_modifiers.each_cons(2) do |t, n|
          str += t.print
          str += ' ' unless t.left_parenthesis? || n.right_parenthesis?
        end
        str += without_modifiers.last.print

        str
      end

      def ==(other)
        value == other.value && type == other.type
      end
    end
  end
end
