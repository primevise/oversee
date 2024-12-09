class Oversee::Field::Value::RichText < Oversee::Field::Value
  def view_template
    p(class: "truncate") { value }
  end
end
