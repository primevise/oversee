class Oversee::Field::Input < Oversee::Base
  MAP = {
    string: Oversee::Field::Input::String,
    boolean: Oversee::Field::Input::Boolean,
    integer: Oversee::Field::Input::Integer,
    datetime: Oversee::Field::Input::Datetime,
    text: Oversee::Field::Input::String,
    enum: Oversee::Field::Input::String,
    belongs_to: Oversee::Field::Input::BelongsTo,
  }

  def initialize(key: nil, value: nil, datatype: :string, **options)
    @key = key
    @value = value
    @datatype = datatype
    @options = options
  end

  def view_template
    render component_class.new(key: @key, value: @value, **@options)
  end

  private

  def component_class
    MAP[@datatype.to_sym] || Oversee::Field::Input::String
  end

  private

  def field_id = "resource_#{@key.to_s}"
  def field_name = "resource[#{@key.to_s}]"
end
