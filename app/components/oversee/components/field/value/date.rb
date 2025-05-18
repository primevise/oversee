class Oversee::Components::Field::Value::Date < Oversee::Components::Field::Value
  def view_template
    time(title: value.to_s) { value&.to_fs(:long) }
  end
end
