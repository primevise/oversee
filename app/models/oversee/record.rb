class Oversee::Record
  def initialize(record:, entity: nil, **attributes)
    @record = record
    @entity = entity || Oversee::Entity.new(entity: record.class)
  end
end
