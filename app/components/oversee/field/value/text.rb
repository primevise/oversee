class Oversee::Field::Value::Text < Oversee::Field::Value
  def view_template
    p(class: "truncate") { value }
  end
end
