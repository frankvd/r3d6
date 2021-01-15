module R3D6
    module Parser
        class Token
            Unknown = 0
            Number = 1
            Dice = 2
            DiceRollModifier = 3
            Operator = 4

            attr_accessor :type
            attr_accessor :value

            def initialize(type = Token::Unknown, value = '')
                @type = type
                @value = value
            end

            def ==(other)
                value == other.value && type ==  other.type
            end
        end
    end
end