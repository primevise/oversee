class Oversee::Components::Field::Input::RichText < Oversee::Components::Field::Input
  register_element :trix_editor

  def view_template
    div do
      input(type: "hidden", id: field_id, name: field_name, value:)
      trix_editor(id: "#{field_id}_trix_editor", input: field_id)
    end
  end
end
