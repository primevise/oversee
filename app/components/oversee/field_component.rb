module Oversee
  class FieldComponent < Phlex::HTML
    # A map for components to use when rendering a key
    LABEL_MAP = {
      string: Oversee::Fields::Label::StringComponent,
      boolean: Oversee::Fields::Label::BooleanComponent,
      integer: Oversee::Fields::Label::IntegerComponent,
      datetime: Oversee::Fields::Label::DatetimeComponent,
      text: Oversee::Fields::Label::TextComponent,
      enum: Oversee::Fields::Label::EnumComponent
    }
    
    # A map for components to use when rendering a value
    VALUE_MAP = {
      string: Oversee::Fields::Value::StringComponent,
      boolean: Oversee::Fields::Value::BooleanComponent,
      integer: Oversee::Fields::Value::IntegerComponent,
      datetime: Oversee::Fields::Value::DatetimeComponent,
      text: Oversee::Fields::Value::TextComponent,
      enum: Oversee::Fields::Value::EnumComponent
    }

    # A map for components to use when rendering a form input field
    INPUT_MAP ={}

    MAP = {
      label: LABEL_MAP,
      value: VALUE_MAP,
      input: INPUT_MAP,
    }

    def initialize(datatype: :string, key: nil, value: nil, kind: :value)
      @kind = kind
      @datatype = datatype
      @key = key
      @value = value
    end

    def template
      render MAP[@kind][@datatype.to_sym].new(datatype: @datatype, key: @key, value: @value)
    end
  end
end