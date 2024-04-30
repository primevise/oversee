module Oversee
  module Fields
    module Value
      class IntegerComponent < Phlex::HTML
        def initialize(key: nil, value: nil, kind: :value)
          @value = value
        end

        def template
          return p(class: "text-gray-500 text-xs"){ "—" } if @value.blank?
          p { @value }
        end
      end
    end
  end
end
