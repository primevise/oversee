class Oversee::Components::Field::Input::Json < Oversee::Components::Field::Input
  def view_template
    textarea(type: "text", id: field_id, name: field_name, class: "flex border px-4 py-2 text-sm w-full rounded-sm") { value.to_s }
  end
end
