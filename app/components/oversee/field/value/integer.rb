class Oversee::Field::Value::Integer < Phlex::HTML
  def initialize(key: nil, value: nil, kind: :value)
    @value = value
  end

  def view_template
    p { @value }
  end
end
