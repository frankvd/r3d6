# frozen_string_literal: true

module R3D6
  module Parser
    class Node
      attr_accessor :value, :left, :right, :meta

      def initialize(value, left = nil, right = nil)
        @value = value
        @left = left
        @right = right
        @meta = {}
      end

      def echo(buffer = '')
        buffer = left.echo(buffer) unless left.nil?
        buffer += meta[:echo]
        buffer = right.echo(buffer) unless right.nil?

        buffer
      end

      def ==(other)
        value == other.value && left == other.left && right == other.right
      end
    end
  end
end
