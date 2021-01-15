module R3D6::Parser
    module Modifiers
        class DropLowest
            attr_accessor :num

            def initialize(num)
                @num = num
            end

            def apply(dice)
                return dice if num == 0

                drop = []
                dice.each do |die|
                    drop << die
                    drop = drop.sort_by{|d| d.value}.take num
                end

                drop.each do |die|
                    die.state = :dropped
                end

                dice
            end

            def ==(other)
                num == other.num
            end
        end
    end
end