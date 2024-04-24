module Oversee
  module Fields
    module Value
      class TextComponent < Phlex::HTML
        def initialize(datatype: :string, key: nil, value: nil, kind: :value)
          @value = value
        end

        def template
          return p(class: "text-gray-500 text-xs"){ "—" } if @value.blank?
          p(class: "truncate") { @value }
        end
      end
    end
  end
end
