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
        svg(
          xmlns: "http://www.w3.org/2000/svg",
          class: "h-3 w-3",
          width: "24",
          height: "24",
          viewbox: "0 0 24 24",
          stroke_width: "2",
          stroke: "currentColor",
          fill: "none",
          stroke_linecap: "round",
          stroke_linejoin: "round"
        ) do |s|
          s.path(stroke: "none", d: "M0 0h24v24H0z", fill: "none")
          s.path(d: "M6 4l12 0")
          s.path(d: "M12 4l0 16")
        end
        p { @key }
      end
    end
  end
end