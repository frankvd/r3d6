module R3D6::Parser
    class Die
        attr_accessor :faces
        attr_accessor :value
        attr_accessor :state

        def initialize(faces, value)
            @faces = faces
            @value = value
            @state = :default
        end

        def to_s
            str = value.to_s
            str += "\u0335" if state == :dropped
            str
        end
    end
end