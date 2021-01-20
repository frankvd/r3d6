# frozen_string_literal: true

module R3D6
  module Parser
    class Die
      attr_accessor :faces, :value, :state

      def initialize(faces, value, state = :default)
        @faces = faces
        @value = value
        @state = state
      end

      def to_s
        str = value.to_s
        str += "\u0335" if state == :dropped
        str
      end

      def ==(other)
        faces == other.faces && value == other.value && state == other.state
      end
    end
  end
end
