class Oversee::Field::Value::String < Oversee::Field::Value
  def view_template
    return p(class: "text-gray-400 text-xs uppercase") { "Empty" } if @value == ""
    return p(class: "text-gray-400 text-xs uppercase") { "Redacted" } if sensitive?
    p(class: "truncate") { value }
  end

  private

  def sensitive?
    key&.downcase&.include?("password") || key&.downcase&.include?("token")
  end
end
