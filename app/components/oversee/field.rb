class Oversee::Field < Oversee::Base
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

  def resource_class_name
    @resource_class_name ||= @resource.class.name
  end

  def field_id
    @field_id ||= "resource_#{key}"
  end
  def field_name
    @field_name ||= "resource[#{key}]"
  end

  def field_form_id
    @form_id ||= dom_id(resource, "#{key}_form")
  end

  # def __SET__(...) = Oversee::Field::Set.new(...)
  # def __LABEL__(...) = Oversee::Field::Label.new(...)
end
