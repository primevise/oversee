module Oversee
  module Fields
    class StringComponent < Phlex::HTML
      def initialize(value)
        @value = value
      end

      def template
        p { @value }
      end
    end
  end
end