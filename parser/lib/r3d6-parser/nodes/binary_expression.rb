module R3D6::Parser
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

            def to_i(x)
                x.is_a?(R3D6::Parser::DiceRoll) ? x.sum : x
            end
        end
    end
end