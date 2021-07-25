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
        @operand_queue = []
        @operator_queue = []
      end

      # @param tokens [Array<Token>]
      def parse(tokens)
        tokens.each do |t|
          read_token(t)
        end

        output_operator @operator_queue.pop until @operator_queue.empty?

        @operand_queue.pop
      end

      # @param token [Token]
      def read_token(token)
        case token.type
        when Token::NUMBER
          queue_operand Nodes::Integer.new(token.value.to_i)
        when Token::DICE
          queue_operand Nodes::DiceRoll.new(DiceRoll.from_s(token.value))
        when Token::DICE_ROLL_MODIFIER
          add_modifier token
        when Token::VARIABLE
          queue_operand Nodes::Variable.new(token.value)
        when Token::OPERATOR
          process_operator token
        when Token::OPEN_PARENTHESIS
          queue_operator token
        when Token::CLOSE_PARENHESIS
          process_close_parenthesis token
        end
      end

      def queue_operand(node)
        @operand_queue << node
      end

      def queue_operator(token)
        @operator_queue << token
      end

      def process_operator(token)
        while !@operator_queue.empty? &&
              !@operator_queue.last.left_parenthesis? &&
              (
                precedence(@operator_queue.last) > precedence(token) ||
                (precedence(@operator_queue.last) == precedence(token) && left_associative?(token))
              )
          output_operator(@operator_queue.pop)
        end

        queue_operator(token)
      end

      def process_close_parenthesis(_token)
        while @operator_queue.last.type != Token::OPEN_PARENTHESIS
          operator = @operator_queue.pop
          raise 'Mismatched parenthesis' if operator.nil?

          output_operator operator
        end

        operator = @operator_queue.pop
        raise 'Mismatched prenthesis' if operator.type != Token::OPEN_PARENTHESIS
      end

      def precedence(token)
        case token.value
        when '^'
          4
        when '/', '*'
          3
        when '+', '-'
          2
        end
      end

      def left_associative?(token)
        case token.value
        when '^'
          false
        else
          true
        end
      end

      def output_operator(token)
        right = @operand_queue.pop
        left = @operand_queue.pop
        @operand_queue << Nodes::BinaryExpression.new(token.value, left, right)
      end

      def add_modifier(token)
        @operand_queue.last.value.modifiers << Modifier.from_s(token.value)
      end
    end
  end
end
