module Oversee
  class FieldComponent < Phlex::HTML
    # A map for components to use when rendering a value
    VALUE_MAP = {
      string: Oversee::Field::Value::StringComponent,
      boolean: Oversee::Field::Value::BooleanComponent,
      integer: Oversee::Field::Value::IntegerComponent,
      datetime: Oversee::Field::Value::DatetimeComponent,
      text: Oversee::Field::Value::TextComponent,
      enum: Oversee::Field::Value::EnumComponent
    }

    # A map for components to use when rendering a form input field
    INPUT_MAP ={
      string: Oversee::Fields::Input::StringComponent,
      boolean: Oversee::Fields::Input::StringComponent,
      integer: Oversee::Fields::Input::IntegerComponent,
      datetime: Oversee::Fields::Input::DatetimeComponent,
      text: Oversee::Fields::Input::StringComponent,
      enum: Oversee::Fields::Input::StringComponent,
    }

    MAP = {
      value: VALUE_MAP,
      input: INPUT_MAP,
    }

    def initialize(resource: nil, datatype: :string, kind: :value, key: nil, value: nil)
      @kind = kind
      @datatype = VALUE_MAP.key?(datatype) ? datatype : :text
      @key = key
      @value = value || nil
    end

    def view_template
      render MAP[@kind][@datatype.to_sym].new(key: @key, value: @value)
    end
  end
end
