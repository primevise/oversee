module Oversee
  class FieldComponent < Phlex::HTML
    # A map for components to use when rendering a key
    KEY_MAP = {}
    
    # A map for components to use when rendering a value
    VALUE_MAP = {
      string: Oversee::Fields::StringComponent,
      boolean: Oversee::Fields::BooleanComponent,
      integer: Oversee::Fields::IntegerComponent,
      datetime: Oversee::Fields::DatetimeComponent,
      text: Oversee::Fields::TextComponent,
      enum: Oversee::Fields::EnumComponent,
    }

    # A map for components to use when rendering a form input field
    INPUT_MAP ={}

    def initialize(datatype:, value:)
      @datatype = datatype
      @value = value
    end

    def template
      render VALUE_MAP[@datatype.to_sym].new(@value)
    end

    def display_value
      @value.present? ? @value : "N/A"
    end
  end
end