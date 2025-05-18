class Oversee::Components::Field::Value::Enum < Oversee::Components::Field::Value
  def view_template
    p(class:"inline-flex px-2 py-1 text-red-500") { value.to_s }
  end
end
