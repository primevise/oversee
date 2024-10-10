class Oversee::Filter
  def initialize(collection:, params: nil)
    @collection = collection
    @params = params
  end

  def extract_filters
    @filters ||= @params[:filters]
  end
end
