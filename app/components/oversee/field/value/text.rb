class Oversee::Field::Value::Text < Phlex::HTML
  def initialize(datatype: :string, key: nil, value: nil, kind: :value)
    @value = value
  end

  def view_template
    p(class: "truncate") { @value }
  end
end
