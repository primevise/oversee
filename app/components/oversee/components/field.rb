class Oversee::Components::Field < Oversee::Components::Base
  attr_reader :resource
  attr_reader :key
  attr_reader :value
  attr_reader :datatype
  attr_reader :options

  def initialize(resource: nil, key: nil, value: nil, datatype: nil, **options)
    @resource = resource
    @key = key
    @value = value
    @datatype = datatype
    @options = options
  end

  def view_template(&)
    div(id: dom_id(resource, key), class: "flex flex-col gap-2.5") do
      render Oversee::Components::Field::Label.new(key:, datatype:)
      render Oversee::Components::Field::Input.new(resource:, key:, value:, datatype:, **options)
      yield if block_given?
    end
  end

  private

  def __LABEL__ = Oversee::Components::Field::Label.new(resource:, key:, value:, datatype:, **options)
  def __VALUE__ = Oversee::Components::Field::Value.new(resource:, key:, value:, datatype:, **options)
  def __INPUT__ = Oversee::Components::Field::Input.new(resource:, key:, value:, datatype:, **options)
  def __FORM__ = Oversee::Components::Field::Form.new(resource:, key:, value:, datatype:, **options)
  def __SET__ = Oversee::Components::Field::Set.new(resource:, key:, value:, datatype:, **options)

  def field_id
    @field_id ||= "record_#{key}"
  end

  def field_name
    @field_name ||= "record[#{key}]"
  end

  def field_form_id
    @form_id ||= dom_id(resource, "#{key}_form")
  end

  def resource_class_name
    @resource_class_name ||= @resource.class.name
  end
end
