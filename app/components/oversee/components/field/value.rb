class Oversee::Components::Field::Value < Oversee::Components::Base
  MAP = {
    string: Oversee::Components::Field::Value::String,
    belongs_to: Oversee::Components::Field::Value::BelongsTo,
    boolean: Oversee::Components::Field::Value::Boolean,
    date: Oversee::Components::Field::Value::Date,
    datetime: Oversee::Components::Field::Value::Datetime,
    enum: Oversee::Components::Field::Value::Enum,
    integer: Oversee::Components::Field::Value::Integer,
    json: Oversee::Components::Field::Value::Json,
    jsonb: Oversee::Components::Field::Value::Json,
    rich_text: Oversee::Components::Field::Value::RichText,
    text: Oversee::Components::Field::Value::Text,
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
    MAP[datatype.to_sym] || Oversee::Components::Field::Value::String
  end

  def for_table?
    @options[:for_table] || false
  end
end
