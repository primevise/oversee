class Oversee::Field::Value::String < Phlex::HTML
  def initialize(key: nil, value: nil, kind: :value)
    @key = key
    @value = value
    @kind = kind
  end

  def view_template
    return p(class: "text-gray-400 text-xs uppercase"){ "Empty" } if @value == ""

    if @key&.downcase&.include?("password") ||  @key&.downcase&.include?("token")
      p { "[REDACTED]" }
    else
      p(class: "truncate") { @value }
    end
  end
end
