class Oversee::Resource
  def initialize(resource_class:, resource: nil)
    @resource_class = resource_class
    @resource = resource
    @resource_class_name = resource_class.to_s
  end

  # Route helpers
  def resources_path

  end

  def resource_path
  end

  # Columns
  def columns_for_create
    excluded_columns = [@resource_class.primary_key, "created_at", "updated_at"]
    @resource_class.columns_hash.except(*excluded_columns)
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
end
