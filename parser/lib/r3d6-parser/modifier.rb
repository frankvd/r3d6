# frozen_string_literal: true

module R3D6
  module Parser
    module Modifier
      def self.from_s(str)
        type, value = [str[0], str[1..-1]]
        case type
        when 'd'
          Modifiers::DropLowest.new(value.to_i)
        when 'k'
          Modifiers::KeepHighest.new(value.to_i)
        end
      end
    end
  end
end
