class Oversee::Components::Field::Value::Datetime < Oversee::Components::Field::Value
  def view_template
    time(title: value.to_s) { value&.to_fs(:long) || "N/A" }
  end
end
