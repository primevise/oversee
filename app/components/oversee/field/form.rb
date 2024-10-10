class Oversee::Field::Form < Oversee::Base
  include Phlex::Rails::Helpers::FormWith

  def initialize(resource:, key: nil, value: nil, datatype: :string, method: :patch)
    @resource = resource
    @key = key
    @value = value
    @datatype = datatype
    @method = method
  end

  def view_template
    form_with(id: dom_id(@resource, @key), model: @resource, url: helpers.update_resource_path(resource_class_name: resource_class_name, id: @resource.id), method: @method, class: "flex items-center w-full gap-4") do |form|
      input type: :hidden, id: "oversee_key", name: "oversee_key", value: @key
      input type: :hidden, id: "oversee_datatype", name: "oversee_datatype", value: @datatype
      render Oversee::Field::Input.new(key: @key, value: @value, datatype: @datatype)
      button(class:"h-9 bg-gray-900 hover:bg-gray-700 text-white inline-flex items-center cursor-pointer gap-2 px-4 rounded-full text-xs font-medium") {
        save_icon
        plain "Save"
      }
    end
  end

  private

  def resource_class_name
    @resource.class.name
  end

  def save_icon
    svg(
      stroke_width: "2.5",
      viewbox: "0 0 24 24",
      fill: "none",
      xmlns: "http://www.w3.org/2000/svg",
      class: "size-4",
      color: "currentColor"
    ) do |s|
      s.path(
        d: "M5 13L9 17L19 7",
        stroke: "currentColor",
        stroke_width: "2.5",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
    end
  end

end
