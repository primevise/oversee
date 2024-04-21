module Oversee
  module Fields
    module Input
      class StringComponent < Phlex::HTML
        def initialize(key, value)
          @key = key
          @value = value
        end

        def view_template
          input type: "text", name: @key, value: @value, class: ""
        end
      end
    end
  end
end
