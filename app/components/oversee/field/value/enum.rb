class Oversee::Field::Value::Enum < Phlex::HTML
  def initialize(key: nil, value: nil, kind: :value)
    @value = value
  end

  def view_template
    p(class:"inline-flex px-2 py-1 text-red-500") { @value.to_s }
  end
end
