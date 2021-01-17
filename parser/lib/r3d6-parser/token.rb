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

      def ==(other)
        value == other.value && type == other.type
      end
    end
  end
end
