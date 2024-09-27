class Oversee::Field::Input::String < Phlex::HTML
  def initialize(key:, value:)
    @key = key
    @value = value
  end

  def view_template
    input type: "text", id: field_id, name: field_name, value: @value, class: "border rounded-md px-4 py-2 text-sm w-full"
  end

  private

  def field_id
    "resource_#{@key.to_s}"
  end

  def field_name
    "resource[#{@key.to_s}]"
  end
end
