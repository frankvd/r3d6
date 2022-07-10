# frozen_string_literal: true

module R3D6
  module Parser
    class Variable
      attr_accessor :name, :value

      def initialize(name, value = nil)
        @name = name
        @value = value
      end

      def ==(other)
        name == other.name && value == other.value
      end
    end
  end
end