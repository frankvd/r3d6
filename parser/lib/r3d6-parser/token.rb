module R3D6
    module Parser
        class Token
            Number = 0
            Dice = 1
            Operator = 2

            attr_accessor :type
            attr_accessor :value

            def initialize(type = 0, value = '')
                @type = type
                @value = value
            end

            def ==(other)
                value == other.value && type ==  other.type
            end
        end
    end
end