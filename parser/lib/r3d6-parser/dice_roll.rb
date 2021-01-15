require 'r3d6-parser/die'

module R3D6::Parser
    class DiceRoll
        attr_accessor :dice
        attr_accessor :number
        attr_accessor :die
        attr_accessor :modifiers

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

        def +(x)
            sum + x
        end

        def -(x)
            sum - x
        end

        def ==(other)
            die == other.die && number == other.number && dice == other.dice && modifiers == other.modifiers
        end

        def self.from_s(s)
            DiceRoll.new(*s.split('d').map(&:to_i))
        end

        def to_s
            "#{@number}d#{@die}"
        end
    end
end