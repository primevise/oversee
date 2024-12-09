class Oversee::Field::Input::Integer < Oversee::Field::Input
  def view_template
    input(type: "number", id: field_id, name: field_name, value:, class: "flex w-full border rounded-sm px-4 py-2 text-sm")
  end
end
