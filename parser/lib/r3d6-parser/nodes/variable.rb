# frozen_string_literal: true

module R3D6
  module Parser
    module Nodes
      class Variable < R3D6::Parser::Node
        def evaluate(env = {})
          raise "Undefined variable [#{@value.name}]" unless env.key? @value.name

          @value.value = env[@value.name].to_i
          meta[:echo] = "[#{@value.value}]"
          @value.value
        end
      end
    end
  end
end
