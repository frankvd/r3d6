# frozen_string_literal: true

module R3D6
  module Parser
    module Nodes
      class Integer < R3D6::Parser::Node
        def evaluate(_env = {})
          @value
        end
      end
    end
  end
end
