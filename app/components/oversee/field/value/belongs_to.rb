class Oversee::Field::Value::BelongsTo < Phlex::HTML
  def initialize(key: nil, value: nil, kind: :value)
    @value = value
  end

  def view_template
    p(title: @value) { @value || "N/A" }
  end
end
