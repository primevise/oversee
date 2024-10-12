class Oversee::Field::Value::String < Phlex::HTML
  def initialize(key: nil, value: nil, kind: :value)
    @key = key
    @value = value
    @kind = kind
  end

  def view_template
    return p(class: "text-gray-400 text-xs uppercase") { "Empty" } if @value == ""
    return p(class: "text-gray-400 text-xs uppercase") { "Redacted" } if sensitive?

    p(class: "truncate") { @value }
  end

  private

  def sensitive?
    @key&.downcase&.include?("password") ||  @key&.downcase&.include?("token")
  end
end
