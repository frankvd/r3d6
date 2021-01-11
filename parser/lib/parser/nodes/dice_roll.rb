module R3D6::Parser::Nodes
    class DiceRoll < R3D6::Parser::Node
        def evaluate
            @value.roll
            meta[:echo] = "(#{@value.dice.join(" + ")})"
            @value
        end
    end
end