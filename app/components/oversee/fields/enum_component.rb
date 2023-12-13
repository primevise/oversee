module Oversee
  module Fields
    class EnumComponent < Phlex::HTML
      def initialize(value)
        @value = value
      end

      def template
        p { @value.to_s }
      end
    end
  end
end