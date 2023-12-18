module Oversee
  module Fields
    class StringComponent < Phlex::HTML
      def initialize(value, key: nil, kind: :value)
        @key = key
        @value = value
        @kind = kind
      end

      def template
        value_template
      end

      private 

      def value_template
        p { @value }
      end
      
      def input_template

      end

      def key_template

      end
    end
  end
end