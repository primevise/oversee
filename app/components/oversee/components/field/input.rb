class Oversee::Components::Field::Input < Oversee::Components::Field
  MAP = {
    belongs_to: Oversee::Components::Field::Input::BelongsTo,
    boolean: Oversee::Components::Field::Input::Boolean,
    date: Oversee::Components::Field::Input::Date,
    datetime: Oversee::Components::Field::Input::Datetime,
    enum: Oversee::Components::Field::Input::String,
    integer: Oversee::Components::Field::Input::Integer,
    json: Oversee::Components::Field::Input::Json,
    jsonb: Oversee::Components::Field::Input::Json,
    rich_text: Oversee::Components::Field::Input::RichText,
    string: Oversee::Components::Field::Input::String,
    text: Oversee::Components::Field::Input::String,
  }

  def view_template
    render component_class.new(key:, value:, **@options)
  end

  private

  def component_class
    MAP[@datatype.to_sym] || Oversee::Components::Field::Input::String
  end
end
