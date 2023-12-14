module Oversee
  module Fields
    class DatetimeComponent < Phlex::HTML
      def initialize(value)
        @value = value
      end

      def template
        p { @value&.to_fs(:short) || "N/A" }
      end
    end
  end
end