class Oversee::Field::Input::Datetime < Oversee::Field::Input
  def initialize(key:, value:)
    @key = key
    @value = value
  end

  def view_template
    input type: "datetime-local", id: field_id, name: field_name, value: @value&.strftime("%Y-%m-%dT%T"), class: "flex w-full border rounded-sm px-4 py-2 text-sm"
  end
end
