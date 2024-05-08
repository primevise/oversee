class Oversee::Fields::DisplayRowComponent < Phlex::HTML
  include Phlex::Rails::Helpers::DOMID
  include Phlex::Rails::Helpers::Routes

  def initialize(key:, resource:, datatype:, value:)
    @datatype = datatype
    @resource = resource
    @key = key
    @value = value
  end

  def view_template
    div(
      id: dom_id(@resource, @key),
      class:
        "py-4 px-8 hover:bg-gray-50 group flex items-center justify-between"
    ) do
      div do
        render Oversee::FieldLabelComponent.new(key: @key, datatype: @datatype)
        div(class: "mt-2 bg-gray-100 rounded px-4 py-2 min-w-64") do
          render Oversee::FieldComponent.new(kind: :value, datatype: @datatype, value: @resource.send(@key))
        end
      end
      div do
        a(
          href:
            (
              helpers.input_field_resource_path(
                @resource.id,
                resource: @resource.class,
                key: @key
              )
            ),
          data_turbo_stream: "true",
          class:
            "opacity-0 group-hover:opacity-100 transition h-8 w-8 rounded-md bg-white border inline-flex justify-center items-center text-gray-400 hover:text-gray-800"
        ) do
          svg(
            xmlns: "http://www.w3.org/2000/svg",
            viewbox: "0 0 16 16",
            fill: "currentColor",
            data_slot: "icon",
            class: "w-4 h-4"
          ) do |s|
            s.path(
              d:
                "M13.488 2.513a1.75 1.75 0 0 0-2.475 0L6.75 6.774a2.75 2.75 0 0 0-.596.892l-.848 2.047a.75.75 0 0 0 .98.98l2.047-.848a2.75 2.75 0 0 0 .892-.596l4.261-4.262a1.75 1.75 0 0 0 0-2.474Z"
            )
            s.path(
              d:
                "M4.75 3.5c-.69 0-1.25.56-1.25 1.25v6.5c0 .69.56 1.25 1.25 1.25h6.5c.69 0 1.25-.56 1.25-1.25V9A.75.75 0 0 1 14 9v2.25A2.75 2.75 0 0 1 11.25 14h-6.5A2.75 2.75 0 0 1 2 11.25v-6.5A2.75 2.75 0 0 1 4.75 2H7a.75.75 0 0 1 0 1.5H4.75Z"
            )
          end
        end
      end
    end
  end
end
