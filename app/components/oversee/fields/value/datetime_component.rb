module Oversee
  module Fields
    module Value
      class DatetimeComponent < Phlex::HTML
        def initialize(datatype: :string, key: nil, value: nil, kind: :value)
          @value = value
        end

        def template
          p { @value&.to_fs(:short) || "N/A" }
        end
      end
    end
  end
end