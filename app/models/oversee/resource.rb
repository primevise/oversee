class Oversee::Resource
  attr_reader :resource_class
  attr_reader :resource_class_name
  attr_reader :instance

  def initialize(resource_class:, instance: nil)
    @resource_class = resource_class
    @resource_class_name = resource_class.to_s
    @instance = instance
  end

  # Route helpers
  def resources_path

  end

  def resource_path
  end

  # Columns
  def columns_for_create
    excluded_columns = [resource_class.primary_key, "created_at", "updated_at"]
    resource_class.columns_hash.except(*excluded_columns)
  end

  def columns_for_show

  end

  # Associations
  def associations
    map = {
      belongs_to: [],
      has_many: [],
      has_one: [],
      has_and_belongs_to_many: []
    }

    @resource_class.reflect_on_all_associations.each do |association|
      map[association.macro] << {
        name: association.name,
        class_name: association.class_name,
        foreign_key: association.foreign_key,
        optional: association.macro == :belongs_to ? !!association.options[:optional] : true,
        through: association.options[:through]
      }
    end

    return map
  end

  def foreign_keys
    resource_class.reflections.map do |name, reflection|
      reflection.foreign_key if reflection.belongs_to?
    end.compact
  end
end
