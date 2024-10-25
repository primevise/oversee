class Oversee::Resources::FieldsController < Oversee::ResourcesController
  # Renders the display field for a resource
  def show
  end

  # Renders the input field for a resource
  def input
    set_resource

    key = params[:key].to_sym
    value = @resource.send(key)
    datatype = @resource.class.columns_hash[key.to_s].type

    field_dom_id = dom_id(@resource, key)
    field = Oversee::Field::Form.new(resource: @resource, datatype:, key:, value:)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(field_dom_id, field)
      end
    end
  end

  private
end
