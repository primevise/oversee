class Oversee::Field::Value < Oversee::Base
  MAP = {
    string: Oversee::Field::Value::String,
    boolean: Oversee::Field::Value::Boolean,
    integer: Oversee::Field::Value::Integer,
    datetime: Oversee::Field::Value::Datetime,
    text: Oversee::Field::Value::Text,
    enum: Oversee::Field::Value::Enum,
    belongs_to: Oversee::Field::Value::BelongsTo,
  }

  attr_reader :key
  attr_reader :value
  attr_reader :datatype

  def initialize(key: nil, value: nil, datatype: :string, **options)
    @key = key
    @value = value
    @datatype = datatype
    @options = options

    @class = @options[:class]
  end

  def view_template
    return p(class: "text-gray-400 text-xs"){ "—" } if value.nil?
    render component_class.new(key:, value:, **@options)
  end

  private

  def component_class
    MAP[datatype.to_sym] || Oversee::Field::Value::String
  end

  def for_table?
    @options[:for_table] || false
  end
end
