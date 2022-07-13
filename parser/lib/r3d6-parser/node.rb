# frozen_string_literal: true

module R3D6
  module Parser
    class Node
      attr_accessor :value, :left, :right

      def initialize(value, left = nil, right = nil)
        @value = value
        @left = left
        @right = right
      end

      def ==(other)
        value == other.value && left == other.left && right == other.right
      end
    end
  end
end
