module R3D6::Parser
    class DiceRoll
        attr_accessor :dice

        def initialize(number, die)
            @number = number
            @die = die

            @dice = []
        end

        def roll
            @dice = []
            @number.times do 
                @dice << rand(1..@die)
            end

            self
        end

        def sum
            @dice.reduce(0, :+)
        end

        def +(x)
            sum + x
        end

        def -(x)
            sum - x
        end

        def self.from_s(s)
            DiceRoll.new(*s.split('d').map(&:to_i))
        end

        def to_s
            "#{@number}d#{@die}"
        end
    end
end