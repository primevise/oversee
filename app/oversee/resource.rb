class Resource
  def initialize(resource)
    @resource = resource
  end

  def columns_for_create
    excluded_columns = [@resource.class.primary_key, "created_at", "updated_at"]
    @resource.columns_hash.except(*excluded_columns)
  end
end
