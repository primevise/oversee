module Oversee
  class FieldComponent < Phlex::HTML
    MAP = {
      string: Oversee::Fields::StringComponent,
      boolean: Oversee::Fields::BooleanComponent,
      integer: Oversee::Fields::IntegerComponent,
      datetime: Oversee::Fields::DatetimeComponent,
      text: Oversee::Fields::TextComponent,
      enum: Oversee::Fields::EnumComponent,
    }

    def initialize(datatype:, value:)
      @datatype = datatype
      @value = value
    end

    def template
      render MAP[@datatype.to_sym].new(@value)
    end

    def display_value
      @value.present? ? @value : "N/A"
    end
  end
end