# frozen_string_literal: true

module R3D6
  module Parser
    module Nodes
      class BinaryExpression < R3D6::Parser::Node
        def evaluate(env = {})
          left = to_i @left.evaluate env
          right = to_i @right.evaluate env
          case @value
          when '+'
            left + right
          when '-'
            left - right
          when '*'
            left * right
          when '/'
            left / right
          end
        end

        def to_i(operand)
          operand.is_a?(R3D6::Parser::DiceRoll) ? operand.sum : operand
        end
      end
    end
  end
end
