module Oversee
  module Fields
    module Label
      class DatetimeComponent < Phlex::HTML
        def initialize(datatype: :datetime, key: nil, value: nil, kind: :value)
          @key = key
        end

        def template
          div(class:"inline-flex shrink-0 items-center space-x-2") do
            div(class: "h-5 w-5 bg-gray-100 shrink-0 inline-flex items-center justify-center rounded") do
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
                    "M4 7a2 2 0 0 1 2 -2h12a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-12a2 2 0 0 1 -2 -2v-12z"
                )
                s.path(d: "M16 3v4")
                s.path(d: "M8 3v4")
                s.path(d: "M4 11h16")
                s.path(d: "M11 15h1")
                s.path(d: "M12 15v3")
              end
            end
            p(class: "uppercase text-xs text-gray-500 font-medium") { @key.to_s.humanize }
          end
        end
      end
    end
  end
end