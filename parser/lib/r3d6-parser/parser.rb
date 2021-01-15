require 'r3d6-parser/node'
require 'r3d6-parser/nodes/binary_expression'
require 'r3d6-parser/nodes/integer'
require 'r3d6-parser/nodes/dice_roll'
require 'r3d6-parser/dice_roll'
require 'r3d6-parser/modifier'
require 'r3d6-parser/modifiers/drop_lowest'

module R3D6::Parser
    class Parser
        def initialize
            @operators = []
            @nodes = []
        end

        # @param tokens [Array<Token>]
        def parse(tokens)
            @operators = []
            @nodes = []
            tokens.each do |t|
                if t.type == Token::Operator 
                    @operators << t.value
                elsif t.type == Token::Number
                    @nodes << Nodes::Integer.new(t.value.to_i, nil, nil)
                elsif t.type == Token::Dice 
                    @nodes << Nodes::DiceRoll.new(DiceRoll.from_s(t.value), nil, nil)
                elsif t.type == Token::DiceRollModifier
                    @nodes.last.value.modifiers << Modifier::from_s(t.value)
                end
            end

            while !@operators.empty?
                operator = @operators.pop
                right = @nodes.pop
                left = @nodes.pop
                @nodes.push(Nodes::BinaryExpression.new(operator, left, right))
            end

            @nodes.pop || Nodes::Integer.new(0, nil, nil)
        end
    end
end