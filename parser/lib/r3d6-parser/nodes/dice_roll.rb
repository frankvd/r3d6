# frozen_string_literal: true

module R3D6
  module Parser
    module Nodes
      class DiceRoll < R3D6::Parser::Node
        def evaluate(_env = {})
          @value.roll
          @value.sum
        end
      end
    end
  end
end
