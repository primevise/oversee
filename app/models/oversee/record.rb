class Oversee::Record
  def initialize(record:, **attributes)
    @record = record
  end

  def resource
    @resource ||= Oversee::Resource.new(resource: record.class)
  end
end
