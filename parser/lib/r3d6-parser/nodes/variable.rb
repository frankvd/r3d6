# frozen_string_literal: true

module R3D6
  module Parser
    module Nodes
      class Variable < R3D6::Parser::Node
        def evaluate(env = {})
          raise "Undefined variable [#{@value}]" unless env.key? @value

          meta[:echo] = "[#{env[@value]}]"
          env[@value].to_i
        end
      end
    end
  end
end
