module R3D6::Parser
    module Modifier
        def self.from_s(s)
            Modifiers::DropLowest.new(s.split('d').last.to_i)
        end
    end
end