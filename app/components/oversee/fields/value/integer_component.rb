module Oversee
  module Fields
    module Value
      class IntegerComponent < Phlex::HTML
        def initialize(datatype: :string, key: nil, value: nil, kind: :value)
          @value = value
        end

        def template
          p { @value }
        end
      end
    end
  end
end