class Oversee::Field::Value::Datetime < Phlex::HTML
  def initialize(key: nil, value: nil, kind: :value)
    @value = value
  end

  def view_template
    time(title: @value) { @value&.to_fs(:long) || "N/A" }
  end
end
