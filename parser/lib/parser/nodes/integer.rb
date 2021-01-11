module R3D6::Parser::Nodes
    class Integer < R3D6::Parser::Node
        def evaluate
            meta[:echo] = @value.to_s
            @value
        end
    end
end