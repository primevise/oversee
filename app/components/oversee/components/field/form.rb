class Oversee::Components::Field::Form < Oversee::Field
  include Phlex::Rails::Helpers::FormWith

  def view_template
    form_with(id: field_form_id, model: resource, url: update_resource_path(resource_class_name: resource_class_name, id: @resource.id), method: @method, class: "flex items-center w-full gap-4") do |form|
      input type: :hidden, id: "oversee_key", name: "oversee_key", value: @key.to_s
      input type: :hidden, id: "oversee_datatype", name: "oversee_datatype", value: @datatype
      render Oversee::Field::Input.new(key: @key, value: @value, datatype: @datatype, **@options)
    end
  end

  private

  def method
    @method ||= @options[:method] || :patch
  end
end
