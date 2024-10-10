module Oversee
  class ResourcesController < BaseController
    include ActionView::RecordIdentifier

    before_action :set_resource_class
    before_action :set_resource, only: %i[show edit update destroy input_field]

    def index
      set_sorting_rules

      @resources = @resource_class.order(@sort_attribute.to_sym => sort_direction)
      @pagy, @resources = pagy(@resources, items: 3)

      render Oversee::Resources::Index.new(
        resources: @resources,
        resource_class: @resource_class,
        pagy: @pagy,
        params: params
      )
    end

    def new
      @resource = @resource_class.new
      render Oversee::Resources::New.new(
        resource: @resource,
        resource_class: @resource_class,
        params: params
      )
    end

    def create
      @resource = @resource_class.new(resource_params)

      respond_to do |format|
        if @resource.update(resource_params)
          format.html { redirect_to resource_path(@resource.id, resource_class_name: @resource_class) }
          format.turbo_stream { redirect_to resource_path(@resource.id, resource_class_name: @resource_class), status: :see_other }
        else
        end
      end
    end

    def show
      render Oversee::Resources::Show.new(
        resource: @resource,
        resource_class: @resource_class,
        resource_associations: resource_associations,
        params: params
      )
    end

    def edit
    end

    def update
      key = params[:oversee_key]
      datatype = params[:oversee_datatype]

      respond_to do |format|
        if @resource.update(resource_params)
          format.html { redirect_to resource_path(@resource.id, resource: @resource_class) }
          format.turbo_stream do
            component = Oversee::Field::Value.new(datatype:, key:, value: @resource.send(key))
            render turbo_stream: [
              turbo_stream.replace(dom_id(@resource, key), component)
            ]
          end
        else
        end
      end
    end

    def destroy
      @resource.destroy
      redirect_to resources_path(resource: @resource_class)
    end

    # Non-standard actions
    def input_field
      set_resource

      key = params[:key].to_sym
      value = @resource.send(key)
      datatype = @resource.class.columns_hash[key.to_s].type

      field_dom_id = dom_id(@resource, key)
      field = Oversee::Field::Form.new(resource: @resource, datatype:, key:, value:)

      actions_dom_id = dom_id(@resource, :"#{key}_actions")

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(field_dom_id, field),
            # turbo_stream.replace(actions_dom_id, "<p>kakalas</p>")
          ]
        end
      end
    end

    private

    def set_resource_class
      @resource_class = params[:resource_class_name].constantize
    end

    def set_resource
      @resource = @resource_class.find(params[:id])
    end

    def resource_associations
      @resource_associations ||= @resource_class.reflect_on_all_associations
    end

    def sort_attribute
      @sort_attribute ||= @resource_class.column_names.include?(params[:sort_attribute]) ? params[:sort_attribute] : "created_at"
    end

    def sort_direction
      @sort_direction ||= ["asc", "desc"].include?(params[:sort_direction]) ? params[:sort_direction] : "desc"
    end

    def set_sorting_rules
      @sort_attribute = params[:sort_attribute] || "created_at"
      @sort_direction = params[:sort_direction] || "desc"
    end

    def resource_params
      params[:resource].delete(:oversee_key)
      params[:resource].delete(:oversee_datatype)

      params.require(:resource).permit!
    end
  end
end
