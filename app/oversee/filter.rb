class Filter
  ALLOWED_OPERATORS = %w[eq in gt gte lt lte].freeze

  def initialize(collection:, params: nil)
    @collection = collection
    @params = params
  end


  def apply
    return @collection if filters.blank?

    filters.each do |key, constraint|
      operator = constraint.keys.first
      next unless ALLOWED_OPERATORS.include?(operator)

      value = constraint[operator]
      chain(key:, operator:, value:)
    end
    return @collection
  end

  private

  # Example params hash:
  # filters[kind][is][]=get => {"kind"=>{"is"=>["get"]}}
  def filters
    @filters ||= @params[:filters]
  end

  def chain(key:, operator:, value:)
    @collection = case operator
    when "eq"
      @collection.then { _1.where(key => value) }
    when "in"
      @collection.then { _1.where(key => value) }
    end
  end
end
