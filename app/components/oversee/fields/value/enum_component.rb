module Oversee
  module Fields
    module Value
      class EnumComponent < Phlex::HTML
        def initialize(datatype: :string, key: nil, value: nil, kind: :value)
          @value = value
        end

        def view_template
          return p(class: "text-gray-500 text-xs"){ "—" } if @value.blank?
          p { @value.to_s }
        end
      end
    end
  end
end
