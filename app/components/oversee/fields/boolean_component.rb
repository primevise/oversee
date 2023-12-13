module Oversee
  module Fields
    class BooleanComponent < Phlex::HTML
      def initialize(value)
        @value = value
      end

      def template
        p { @value.to_s }
      end
    end
  end
end