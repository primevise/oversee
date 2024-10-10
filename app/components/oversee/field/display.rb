class Oversee::Field::Display < Oversee::Base
  def initialize(resource:, key: nil, value: nil, datatype: :string, interactive: true)
    @resource = resource
    @key = key
    @value = value
    @datatype = datatype
    @interactive = interactive
  end

  def view_template
    wrapper_tag(id: dom_id(@resource, @key), href: helpers.resource_input_field_path(resource_class_name: resource_class_name, key: @key), class: "bg-gray-100 h-10 flex px-4 py-2 hover:bg-gray-200 transition-colors w-full cursor-pointer", data: { turbo_stream: true }) do
      render Oversee::Field::Value.new(key: @key, value: @resource.send(@key), datatype: @datatype)
    end
  end

  private

  def resource_class_name
    @resource.class.name
  end

  def wrapper_tag(...)
    @interactive ? a(...) : div(...)
  end
end
