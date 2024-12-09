class Oversee::Field::Value < Oversee::Base
  MAP = {
    string: Oversee::Field::Value::String,
    belongs_to: Oversee::Field::Value::BelongsTo,
    boolean: Oversee::Field::Value::Boolean,
    date: Oversee::Field::Value::Date,
    datetime: Oversee::Field::Value::Datetime,
    enum: Oversee::Field::Value::Enum,
    integer: Oversee::Field::Value::Integer,
    json: Oversee::Field::Value::Json,
    jsonb: Oversee::Field::Value::Json,
    rich_text: Oversee::Field::Value::RichText,
    text: Oversee::Field::Value::Text,
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
