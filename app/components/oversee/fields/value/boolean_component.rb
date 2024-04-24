module Oversee
  module Fields
    module Value
      class BooleanComponent < Phlex::HTML
        def initialize(datatype: :string, key: nil, value: nil, kind: :value)
          @value = value
        end

        def template
          return p(class: "text-gray-500 text-xs"){ "—" } if @value.blank?
          if @value
            svg(
              xmlns: "http://www.w3.org/2000/svg",
              viewbox: "0 0 16 16",
              fill: "currentColor",
              data_slot: "icon",
              class: "w-4 h-4 text-emerald-500"
            ) do |s|
              s.path(
                fill_rule: "evenodd",
                d:
                  "M12.416 3.376a.75.75 0 0 1 .208 1.04l-5 7.5a.75.75 0 0 1-1.154.114l-3-3a.75.75 0 0 1 1.06-1.06l2.353 2.353 4.493-6.74a.75.75 0 0 1 1.04-.207Z",
                clip_rule: "evenodd"
              )
            end
          else
            svg(
              xmlns: "http://www.w3.org/2000/svg",
              viewbox: "0 0 16 16",
              fill: "currentColor",
              data_slot: "icon",
              class: "w-4 h-4 text-red-400"
            ) do |s|
              s.path(
                d:
                  "M5.28 4.22a.75.75 0 0 0-1.06 1.06L6.94 8l-2.72 2.72a.75.75 0 1 0 1.06 1.06L8 9.06l2.72 2.72a.75.75 0 1 0 1.06-1.06L9.06 8l2.72-2.72a.75.75 0 0 0-1.06-1.06L8 6.94 5.28 4.22Z"
              )
            end
          end
        end
      end
    end
  end
end
