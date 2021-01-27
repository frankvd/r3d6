# frozen_string_literal: true

require 'r3d6-parser/node'
require 'r3d6-parser/nodes/binary_expression'
require 'r3d6-parser/nodes/integer'
require 'r3d6-parser/nodes/dice_roll'
require 'r3d6-parser/nodes/variable'
require 'r3d6-parser/dice_roll'
require 'r3d6-parser/modifier'
require 'r3d6-parser/modifiers/drop_lowest'

module R3D6
  module Parser
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
          buffer_token t
        end

        until @operators.empty?
          operator = @operators.pop
          right = @nodes.pop
          left = @nodes.pop
          @nodes.push(Nodes::BinaryExpression.new(operator, left, right))
        end

        @nodes.pop || Nodes::Integer.new(0, nil, nil)
      end

      def buffer_token(token)
        case token.type
        when Token::OPERATOR
          buffer_operator token.value
        when Token::NUMBER
          buffer_number token
        when Token::DICE
          buffer_dice token
        when Token::DICE_ROLL_MODIFIER
          add_modifier token
        when Token::VARIABLE
          buffer_variable token
        end
      end

      def buffer_operator(operator)
        @operators << operator
      end

      def buffer_number(token)
        @nodes << Nodes::Integer.new(token.value.to_i, nil, nil)
      end

      def buffer_dice(token)
        @nodes << Nodes::DiceRoll.new(DiceRoll.from_s(token.value), nil, nil)
      end

      def buffer_variable(token)
        @nodes << Nodes::Variable.new(token.value)
      end

      def add_modifier(token)
        @nodes.last.value.modifiers << Modifier.from_s(token.value)
      end
    end
  end
end
