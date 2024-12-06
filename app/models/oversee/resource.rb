class Oversee::Resource
  attr_reader :resource_class
  attr_reader :resource_class_name
  attr_reader :instance
  attr_reader :rich_text_associations

  attr_accessor :associations

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
  # Structured by association macro
  def associations
    @associations ||= begin
      map = Hash.new { |hash, key| hash[key] = [] }

      @resource_class.reflect_on_all_associations.each do |association|
        map[association.macro] << {
          name: association.name,
          class_name: association.class_name,
          foreign_key: association.foreign_key,
          optional: association.macro == :belongs_to ? !!association.options[:optional] : true,
          through: association.options[:through],
          rich_text: association.name.to_s.start_with?("rich_text_"),
        }
      end
      map
    end
  end

  def foreign_keys
    resource_class.reflections.map do |name, reflection|
      reflection.foreign_key if reflection.belongs_to?
    end.compact
  end

  def rich_text_associations
    @rich_text_associations ||= associations[:has_one].select { |association| association[:rich_text] }
  end
end
