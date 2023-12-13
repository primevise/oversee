module Oversee
  module Fields
    class IntegerComponent < Phlex::HTML
      def initialize(value)
        @value = value
      end

      def template
        p { @value }
      end
    end
  end
end