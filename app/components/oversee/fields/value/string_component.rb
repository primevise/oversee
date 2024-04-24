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
          return p(class: "text-gray-500 text-xs"){ "—" } if @value.blank?

          if @key&.downcase&.include?("password") ||  @key&.downcase&.include?("token")
            p { "[REDACTED]" }
          else
            p(class: "truncate") { @value }
          end
        end
      end
    end
  end
end
