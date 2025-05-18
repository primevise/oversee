class Oversee::Components::Field::Input::BelongsTo < Oversee::Components::Field::Input
  def view_template
    input(type: "text", id: field_id, name: field_name, value:, class: "flex border px-4 py-2 text-sm w-full rounded-sm")
  end
end
