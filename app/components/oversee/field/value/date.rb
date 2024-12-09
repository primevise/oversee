class Oversee::Field::Value::Date < Oversee::Field::Value
  def view_template
    time(title: value.to_s) { value&.to_fs(:long) }
  end
end
