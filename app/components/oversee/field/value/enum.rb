class Oversee::Field::Value::Enum < Oversee::Field::Value
  def view_template
    p(class:"inline-flex px-2 py-1 text-red-500") { value.to_s }
  end
end
