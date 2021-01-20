# frozen_string_literal: true

require 'r3d6-parser/die'

module R3D6
  module Parser
    class DiceRoll
      attr_accessor :dice, :number, :die, :modifiers

      def initialize(number, die)
        @number = [number, 1].max
        @die = die

        @dice = []
        @modifiers = []
      end

      def roll
        @dice = []
        @number.times do
          @dice << Die.new(@die, rand(1..@die))
        end

        apply_modifiers
      end

      def apply_modifiers
        modifiers.each do |modifier|
          modifier.apply(dice)
        end

        self
      end

      def sum
        @dice.reduce(0) do |sum, die|
          sum += die.value unless die.state == :dropped
          sum
        end
      end

      def ==(other)
        die == other.die && number == other.number && dice == other.dice && modifiers == other.modifiers
      end

      def self.from_s(str)
        DiceRoll.new(*str.split('d').map(&:to_i))
      end

      def to_s
        "#{@number}d#{@die}"
      end
    end
  end
end
