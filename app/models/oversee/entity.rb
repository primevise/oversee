# frozen_string_literal: true

# Oversee::Entity is a record class.
class Oversee::Entity
  attr_reader :klass

  def initialize(klass:, **attributes)
    @klass = klass
    raise ArgumentError, "klass must be a class" unless klass.is_a?(Class)
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
