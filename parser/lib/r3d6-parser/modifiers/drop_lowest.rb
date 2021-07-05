# frozen_string_literal: true

module R3D6
  module Parser
    module Modifiers
      class DropLowest
        attr_accessor :num

        def initialize(num)
          @num = num
        end

        def apply(dice)
          return dice if num.zero?

          drop = []
          dice.each do |die|
            drop << die
            drop = drop.sort_by(&:value).take num
          end

          drop.each do |die|
            die.state = :dropped
          end

          dice
        end

        def ==(other) = num == other.num
      end
    end
  end
end
