class Oversee::Field::Input::Boolean < Phlex::HTML
  def initialize(key:, value:)
    @key = key
    @value = value
  end

  def view_template
    select(id: field_id, name: field_name, class: "flex w-full border rounded-sm px-4 py-2 text-sm") do
      option(value: 1, selected: @value) { "True" }
      option(value: 0, selected: !@value) { "False" }
    end
  end

  private

  def field_id
    "resource_#{@key.to_s}"
  end

  def field_name
    "resource[#{@key.to_s}]"
  end
end
