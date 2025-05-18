class Oversee::Components::Field::Value::RichText < Oversee::Components::Field::Value
  def view_template
    p(class: "truncate") { value }
  end
end
