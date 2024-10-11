class Oversee::Field::Value::Datetime < Phlex::HTML
  def initialize(key: nil, value: nil, kind: :value)
    @value = value
  end

  def view_template
    p { @value&.to_fs(:short) || "N/A" }
  end
end
