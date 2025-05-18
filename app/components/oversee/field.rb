class Oversee::Field < Oversee::Components::Base
  attr_reader :resource
  attr_reader :key
  attr_reader :value
  attr_reader :datatype

  def initialize(resource: nil, key: nil, value: nil, datatype: nil, **options)
    @resource = resource
    @key = key
    @value = value
    @datatype = datatype
    @options = options
  end

  def view_template
    plain "Oversee::Field"
  end

  # Sub-components
  def __LABEL__ = Oversee::Field::Label.new(resource:, key:, value:, datatype:, **@options)
  def __VALUE__ = Oversee::Field::Value.new(resource:, key:, value:, datatype:, **@options)
  def __INPUT__ = Oversee::Field::Input.new(resource:, key:, value:, datatype:, **@options)
  def __FORM__ = Oversee::Field::Form.new(resource:, key:, value:, datatype:, **@options)
  def __SET__ = Oversee::Field::Set.new(resource:, key:, value:, datatype:, **@options)

  # Helpers & Decorators
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
