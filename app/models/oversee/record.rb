class Oversee::Record
  def initialize(record:, resource: nil, **attributes)
    @record = record
    @entity = resource || Oversee::Resource.new(resource: record.class)
  end
end
