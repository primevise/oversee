class Oversee::Record
  attr_accessor :record

  def initialize(record:, **attributes)
    @record = record
  end

  def resource
    @resource ||= Oversee::Resource.new(klass: record.class)
  end
end
