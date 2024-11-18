class Oversee::Search
  DEFAULT_SEARCHABLE_ATTRIBUTES = %w[name title email email_address]

  def initialize(collection:, resource_class:, query: nil)
    @collection = collection
    @resource_class = resource_class
    @query = query
  end

  def call
    return @collection if @query.blank? || @resource_class.blank?
    default_searchable_by
  end

  def default_searchable_attribute
    DEFAULT_SEARCHABLE_ATTRIBUTES.each do |attr|
      return attr if @resource_class.column_names.include?(attr)
    end

    return @resource_class.primary_key
  end

  private

  def default_searchable_by
    return @collection.where(default_searchable_attribute => @query) if @resource_class.primary_key == default_searchable_attribute

    @collection
      .where(@resource_class.arel_table[default_searchable_attribute]
      .matches("%#{@query}%"))
  end


end
