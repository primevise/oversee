module Oversee
  module Fields
    module Label
      class EnumComponent < Phlex::HTML
        def initialize(datatype: :enum, key: nil, value: nil, kind: :value)
          @key = key
        end

        def template
          div(class:"inline-flex items-center space-x-2") do
            div(class: "h-5 w-5 bg-gray-100 inline-flex items-center justify-center rounded") do
              svg(
                xmlns: "http://www.w3.org/2000/svg",
                class: "h-2.5 w-2.5",
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
                s.path(
                  d:
                    "M3 3m0 2a2 2 0 0 1 2 -2h14a2 2 0 0 1 2 2v14a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2z"
                )
                s.path(d: "M9 11l3 3l3 -3")
              end
            end
            p(class: "uppercase text-xs text-gray-500 font-medium") { @key.to_s.humanize }
          end
        end
      end
    end
  end
end