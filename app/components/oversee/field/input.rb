class Oversee::Field::Input < Oversee::Base
  MAP = {
    belongs_to: Oversee::Field::Input::BelongsTo,
    boolean: Oversee::Field::Input::Boolean,
    date: Oversee::Field::Input::Date,
    datetime: Oversee::Field::Input::Datetime,
    enum: Oversee::Field::Input::String,
    integer: Oversee::Field::Input::Integer,
    rich_text: Oversee::Field::Input::RichText,
    string: Oversee::Field::Input::String,
    text: Oversee::Field::Input::String,
  }

  attr_reader :key
  attr_reader :value
  attr_reader :datatype

  def initialize(key: nil, value: nil, datatype: :string, **options)
    @key = key
    @value = value
    @datatype = datatype
    @options = options
  end

  def view_template
    render component_class.new(key:, value:, **@options)
  end

  private

  def component_class
    MAP[@datatype.to_sym] || Oversee::Field::Input::String
  end

  private

  def field_id = "resource_#{key.to_s}"
  def field_name = "resource[#{key.to_s}]"
end
