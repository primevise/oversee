class Oversee::Resource
  attr_reader :klass
  attr_reader :associations

  def initialize(klass: nil)
    @klass = klass
    raise ArgumentError, "klass must be a class" unless klass.is_a?(Class)
  end

  # Route helpers
  def index_path(**params)
    "/#{class_name}"
  end

  def show_path(record:, **params)
    # Rails.application.routes.url_helpers.resource_path(instance || object, class_name:)
    "/resources/#{class_name}/#{record.to_param}"
  end

  # Columns
  def columns_for_create
    excluded_columns = [klass.primary_key, "created_at", "updated_at"]
    klass.columns_hash.except(*excluded_columns)
  end

  # Helpers
  # Returns the class name of the entity.
  #
  # This method returns the name of the class as a string.
  #
  # @return [String] the name of the class
  def class_name
    @class_name ||= klass.to_s
  end

  # Associations

  # Returns the associations for the Entity.
  #
  # This method iterates over all associations of the resource class and maps them
  # into a hash categorized by the association type (macro). Each association is
  # represented as a hash containing details such as the name, class name, foreign key,
  # whether it is optional, if it is a through association, and if it is a rich text association.
  #
  # @return [Hash] a hash where the keys are association types and the values are arrays of association details
  def associations
    @associations ||= begin
      map = Hash.new { |hash, key| hash[key] = [] }

      klass.reflect_on_all_associations.each do |association|
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

  # Returns the foreign keys for the Entity.
  #
  # This method iterates over the reflections of the resource class and collects
  # the foreign keys for associations where the reflection belongs to another model.
  #
  # @return [Array<String>] an array of foreign key names
  def foreign_keys
    klass.reflections.map do |name, reflection|
      reflection.foreign_key if reflection.belongs_to?
    end.compact
  end

  # Returns the rich text associations for the Entity.
  #
  # @return [Array<Hash>] an array of hashes representing the rich text associations
  def rich_text_associations
    @rich_text_associations ||= associations[:has_one].select { |association| association[:rich_text] }
  end
end
