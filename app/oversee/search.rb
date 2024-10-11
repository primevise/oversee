class Search
  def initialize(collection:, resource_class:, query: nil)
    @collection = collection
    @resource_class = resource_class
    @query = query
  end

  def call
    return @collection if @query.blank? || @resource_class.blank?

    puts "-" * 40
    puts @query
    puts default_searchable_attribute
    puts "-" * 40

    default_searchable_by
  end

  private

  def default_searchable_by
    @collection.where("#{default_searchable_attribute} LIKE ?", "%#{@query}%")
  end

  def default_searchable_attribute
    return "name" if @resource_class.column_names.include?("name")
    return "title" if @resource_class.column_names.include?("title")
    return @resource_class.primary_key
  end
end
