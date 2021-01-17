# frozen_string_literal: true

module R3D6
  module Parser
    module Modifier
      def self.from_s(str)
        Modifiers::DropLowest.new(str.split('d').last.to_i)
      end
    end
  end
end
