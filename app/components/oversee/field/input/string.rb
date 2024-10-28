class Oversee::Field::Input::String < Oversee::Field::Input
  def initialize(key:, value:)
    @key = key
    @value = value
  end

  def view_template
    input type: "text", id: field_id, name: field_name, value: @value, class: "flex border px-4 py-2 text-sm w-full rounded-sm"
  end
end
