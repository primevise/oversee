class Oversee::Field::Input < Oversee::Base
  MAP = {
    string: Oversee::Field::Input::String,
    boolean: Oversee::Field::Input::Boolean,
    integer: Oversee::Field::Input::Integer,
    datetime: Oversee::Field::Input::Datetime,
    text: Oversee::Field::Input::String,
    enum: Oversee::Field::Input::String
  }

  def initialize(key: nil, value: nil, datatype: :string)
    @key = key
    @value = value
    @datatype = datatype
  end

  def view_template
    render component_class.new(key: @key, value: @value)
  end

  private

  def component_class
    MAP[@datatype.to_sym] || Oversee::Field::Input::String
  end
end
