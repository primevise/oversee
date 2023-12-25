module Oversee
  module Fields
    module Value
      class StringComponent < Phlex::HTML
        def initialize(datatype: :string, key: nil, value: nil, kind: :value)
          @key = key
          @value = value
          @kind = kind
        end

        def template
          if @value&.downcase&.include?("password")
            p { "[REDACTED]" }
          else
            p { @value }
          end
        end
      end
    end
  end
end