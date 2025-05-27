class Oversee::Resource
  attr_reader :resource_class
  attr_reader :associations

  attr_accessor :record

  def initialize(resource_class:, record: nil)
    @resource_class = resource_class
    @record = record
    raise ArgumentError, "resource_class must be a class" unless resource_class.is_a?(Class)
    raise ArgumentError, "resource inherit from ActiveRecord" unless resource_class < ActiveRecord::Base
  end


  # Route helpers
  def index_path(**params)
    "/#{resource_class_name}"
  end

  def show_path(**params)
    raise ArgumentError, "record must be initialized" if record.nil?
    "/#{resource_class_name}/#{record.to_param}"
  end

  # Columns
  def columns_for_create
    excluded_columns = [resource_class.primary_key, "created_at", "updated_at"]
    resource_class.columns_hash.except(*excluded_columns)
  end

  # Helpers
  # Returns the class name of the entity.
  #
  # This method returns the name of the class as a string.
  #
  # @return [String] the name of the class
  def resource_class_name
    @resource_class_name ||= resource_class.name
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

      resource_class.reflect_on_all_associations.each do |association|
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
    resource_class.reflections.map do |name, reflection|
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
