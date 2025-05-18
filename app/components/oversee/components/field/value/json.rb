class Oversee::Components::Field::Value::Json < Oversee::Components::Field::Value
  def view_template
    return p(class: "text-gray-400 text-xs uppercase") { "JSON" } if for_table?
    p(class: "truncate") { value.to_s }
  end
end
