module Oversee
  module Fields
    module Input
      class StringComponent < Phlex::HTML
        def initialize(key, value)
          @key = key
          @value = value
        end

        def template
          p { @value }
        end
      end
    end
  end
end