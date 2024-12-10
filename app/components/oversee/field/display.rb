class Oversee::Field::Display < Oversee::Field
  def view_template
    html_tag(
      id: dom_id(resource, key),
      href: helpers.resource_input_path(resource_class_name:, key:, datatype:),
      title: key.titleize,
      class: "bg-gray-100 h-10 flex items-center justify-between px-4 py-2 hover:bg-gray-200 transition-colors w-full cursor-pointer group",
      data: { turbo_stream: true }
    ) do
      render Oversee::Field::Value.new(key:, value:, datatype:, **@options)
      render Phlex::Icons::Iconoir::Edit.new(class: "text-gray-500 size-4 opacity-0 group-hover:opacity-100 transition-opacity", stroke_width: 1.75)
    end
  end

  private

  def edittable? = @options[:edittable] || true

  def html_tag(...) = edittable? ? a(...) : div(...)
end
