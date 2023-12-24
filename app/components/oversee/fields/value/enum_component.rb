module Oversee
  module Fields
    module Value
      class EnumComponent < Phlex::HTML
        def initialize(datatype: :string, key: nil, value: nil, kind: :value)
          @value = value
        end

        def template
          p { @value.to_s }
        end
      end
    end
  end
end