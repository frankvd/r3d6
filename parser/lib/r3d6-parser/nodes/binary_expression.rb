# frozen_string_literal: true

module R3D6
  module Parser
    module Nodes
      class BinaryExpression < R3D6::Parser::Node
        def evaluate(env = {})
          meta[:echo] = " #{@value} "
          left = @left.evaluate env
          right = @right.evaluate env
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
