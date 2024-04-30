module Oversee
  class FieldComponent < Phlex::HTML
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
    INPUT_MAP ={
      string: Oversee::Fields::Input::StringComponent,
      integer: Oversee::Fields::Input::IntegerComponent,
      datetime: Oversee::Fields::Input::DatetimeComponent,
    }

    MAP = {
      value: VALUE_MAP,
      input: INPUT_MAP,
    }

    def initialize(resource: nil, datatype: :string, kind: :value, key: nil, value: nil)
      @kind = kind
      @datatype = VALUE_MAP.key?(datatype) ? datatype : :text
      @key = key
      @value = value
    end

    def template
      render MAP[@kind][@datatype.to_sym].new(key: @key, value: @value)
    end
  end
end
