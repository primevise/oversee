class Oversee::Components::Field::Input::Datetime < Oversee::Components::Field::Input
  def view_template
    input(type: "datetime-local", id: field_id, name: field_name, value: value&.strftime("%Y-%m-%dT%T"), class: "flex w-full border rounded-sm px-4 py-2 text-sm")
  end
end
