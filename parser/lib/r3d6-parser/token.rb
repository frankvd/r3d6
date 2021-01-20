# frozen_string_literal: true

module R3D6
  module Parser
    class Token
      UNKNOWN = 0
      NUMBER = 1
      DICE = 2
      DICE_ROLL_MODIFIER = 3
      OPERATOR = 4

      attr_accessor :type, :value

      def initialize(type = Token::UNKNOWN, value = '')
        @type = type
        @value = value
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

      def ==(other)
        value == other.value && type == other.type
      end
    end
  end
end
