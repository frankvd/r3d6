# frozen_string_literal: true

module R3D6
  module Parser
    class Die
      attr_accessor :faces, :value, :state

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
end
