class Oversee::Field::Display < Oversee::Base

  attr_reader :resource
  attr_reader :key
  attr_reader :value
  attr_reader :datatype

  def initialize(resource:, key: nil, value: nil, datatype: :string, **options)
    @resource = resource
    @key = key
    @value = value
    @datatype = datatype
    @options = options
  end

  def view_template
    html_tag(
      id: dom_id(resource, key),
      href: helpers.resource_input_path(resource_class_name:, key:, datatype:),
      class: "bg-gray-100 h-10 flex items-center px-4 py-2 hover:bg-gray-200 transition-colors w-full cursor-pointer",
      data: { turbo_stream: true }
    ) do
      render Oversee::Field::Value.new(key:, value:, datatype:, **@options)
    end
  end

  private

  def resource_class_name
    @resource_class_name ||= @resource.class.name
  end

  def html_tag(...)
    edittable? ? a(...) : div(...)
  end

  def edittable? = @options[:edittable] || true
end
