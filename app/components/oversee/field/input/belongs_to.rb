class Oversee::Field::Input::BelongsTo < Oversee::Field::Input
  def initialize(key:, value:, **options)
    @key = key
    @value = value
  end

  def view_template
    input type: "text", id: field_id, name: field_name, value: @value, class: "flex border px-4 py-2 text-sm w-full rounded-sm"

    # select(id: field_id, name: field_name, class: "flex w-full border rounded-sm px-4 py-2 text-sm") do

    #   option(value: 1, selected: @value) { "True" }
    #   option(value: 0, selected: !@value) { "False" }
    # end
  end

  private

  def select_values

  end
end
