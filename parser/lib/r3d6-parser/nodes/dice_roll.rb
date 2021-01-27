# frozen_string_literal: true

module R3D6
  module Parser
    module Nodes
      class DiceRoll < R3D6::Parser::Node
        def evaluate(_env = {})
          @value.roll
          meta[:echo] = "(#{@value.dice.join(' + ')})"
          @value.sum
        end
      end
    end
  end
end
