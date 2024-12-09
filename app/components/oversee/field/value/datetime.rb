class Oversee::Field::Value::Datetime < Oversee::Field::Value
  def view_template
    time(title: value.to_s) { value&.to_fs(:long) || "N/A" }
  end
end
