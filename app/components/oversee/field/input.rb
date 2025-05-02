class Oversee::Field::Input < Oversee::Field
  MAP = {
    belongs_to: Oversee::Field::Input::BelongsTo,
    boolean: Oversee::Field::Input::Boolean,
    date: Oversee::Field::Input::Date,
    datetime: Oversee::Field::Input::Datetime,
    enum: Oversee::Field::Input::String,
    integer: Oversee::Field::Input::Integer,
    json: Oversee::Field::Input::Json,
    jsonb: Oversee::Field::Input::Json,
    rich_text: Oversee::Field::Input::RichText,
    string: Oversee::Field::Input::String,
    text: Oversee::Field::Input::String,
  }

  def view_template
    render component_class.new(key:, value:, **@options)
  end

  private

  def component_class
    MAP[@datatype.to_sym] || Oversee::Field::Input::String
  end
end
