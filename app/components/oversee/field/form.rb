class Oversee::Field::Form < Oversee::Base
  include Phlex::Rails::Helpers::FormWith

  def initialize(resource:, key: nil, value: nil, datatype: :string, method: :patch, **options)
    @resource = resource
    @key = key
    @value = value
    @datatype = datatype
    @method = method
    @options = options
  end

  def view_template
    form_with(id: dom_id(@resource, @key), model: @resource, url: helpers.update_resource_path(resource_class_name: resource_class_name, id: @resource.id), method: @method, class: "flex items-center w-full gap-4") do |form|
      input type: :hidden, id: "oversee_key", name: "oversee_key", value: @key.to_s
      input type: :hidden, id: "oversee_datatype", name: "oversee_datatype", value: @datatype
      render Oversee::Field::Input.new(key: @key, value: @value, datatype: @datatype, **@options)
      button(class:"h-9 bg-gray-900 hover:bg-gray-700 text-white inline-flex items-center cursor-pointer gap-2 px-4 rounded-full text-xs font-medium") {
        render Phlex::Icons::Iconoir::Check.new(class: "size-4")
        plain "Save"
      }
    end
  end

  private

  def resource_class_name
    @resource.class.name
  end
end
