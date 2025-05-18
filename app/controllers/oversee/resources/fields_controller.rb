class Oversee::Resources::FieldsController < Oversee::ResourcesController
  before_action :set_record, only: %i[input]

  # Renders the display field for a resource
  def show
  end

  # Renders the input field for a resource
  def input
    component_dom_id = dom_id(@record, key)
    component = Oversee::Components::Field::Set.new(resource: @record, datatype:, key:, value:, state: :input)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(component_dom_id, component)
      end
    end
  end

  private

  def key
    params[:key].to_sym
  end

  def value
    params[:value] || @record.send(key)
  end

  def datatype
    params[:datatype] || @record.class.columns_hash[key.to_s].type
  end
end
