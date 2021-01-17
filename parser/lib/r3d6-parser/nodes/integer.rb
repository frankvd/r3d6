# frozen_string_literal: true

module R3D6
  module Parser
    module Nodes
      class Integer < R3D6::Parser::Node
        def evaluate
          meta[:echo] = @value.to_s
          @value
        end
      end
    end
  end
end
