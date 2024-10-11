class Oversee::Field::Input::Integer < Phlex::HTML
  def initialize(key:, value:)
    @key = key
    @value = value
  end

  def view_template
    input type: "number", id: field_id, name: field_name, value: @value, class: "flex w-full border rounded-sm px-4 py-2 text-sm"
  end

  private

  def field_id
    "resource_#{@key.to_s}"
  end

  def field_name
    "resource[#{@key.to_s}]"
  end
end
