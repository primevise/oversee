class Oversee::Components::Field::Value::Text < Oversee::Components::Field::Value
  def view_template
    p(class: "truncate") { value }
  end
end
