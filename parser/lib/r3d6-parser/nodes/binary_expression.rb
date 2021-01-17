# frozen_string_literal: true

module R3D6
  module Parser
    module Nodes
      class BinaryExpression < R3D6::Parser::Node
        def evaluate
          meta[:echo] = " #{@value} "
          left = @left.evaluate
          right = @right.evaluate
          case @value
          when '+'
            to_i(left) + to_i(right)
          when '-'
            to_i(left) - to_i(right)
          end
        end

        def to_i(operand)
          operand.is_a?(R3D6::Parser::DiceRoll) ? operand.sum : operand
        end
      end
    end
  end
end
