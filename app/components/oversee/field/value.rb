class Oversee::Field::Value < Oversee::Base
  MAP = {
    string: Oversee::Field::Value::String,
    boolean: Oversee::Field::Value::Boolean,
    integer: Oversee::Field::Value::Integer,
    datetime: Oversee::Field::Value::Datetime,
    text: Oversee::Field::Value::Text,
    enum: Oversee::Field::Value::Enum
  }

  def initialize(key: nil, value: nil, datatype: :string, **options)
    @key = key
    @value = value
    @datatype = datatype
    @options = options

    @class = @options[:class]
  end

  def view_template
    return p(class: "text-gray-400 text-xs"){ "—" } if @value.nil?
    render component_class.new(key: @key, value: @value)
  end

  private

  def component_class
    MAP[@datatype.to_sym] || Oversee::Field::Value::String
  end

  def for_table?
    @options[:for_table] || false
  end
end
