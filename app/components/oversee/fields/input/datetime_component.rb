
module Oversee
  module Fields
    module Input
      class DatetimeComponent < Phlex::HTML
        def initialize(key:, value:)
          @key = key
          @value = value
        end

        def view_template
          input type: "datetime-local", id: field_id, name: field_name, value: @value.strftime("%Y-%m-%dT%T"), class: "border rounded-md px-4 py-2 text-sm"
        end

        private

        def field_id
          "resource_#{@key.to_s}"
        end

        def field_name
          "resource[#{@key.to_s}]"
        end
      end
    end
  end
end
