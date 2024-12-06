class Oversee::Field::Input::RichText < Oversee::Field::Input
  register_element :trix_editor

  attr_reader :key
  attr_reader :value

  def initialize(key:, value:)
    @key = key
    @value = value
  end

  def view_template
    div do
      input(type: "hidden", id: field_id, name: field_name, value:)
      trix_editor(id: "#{field_id}_trix_editor", input: field_id)
    end
  end
end
