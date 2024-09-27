module Oversee
  class ResourcesController < BaseController
    include ActionView::RecordIdentifier

    before_action :set_resource_class, except: [:create, :update]
    before_action :set_resource, only: %i[show edit destroy]

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
    end

    def create
      @resource_class = params[:resource_class].constantize
      @resource = @resource_class.new(resource_params)

      respond_to do |format|
        if @resource.update(resource_params)
          format.html { redirect_to resource_path(@resource.id, resource: @resource_class) }
          format.turbo_stream
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
      @resource_class = params[:resource_class].constantize
      set_resource

      @key = params[:resource][:oversee_key]
      @datatype = params[:resource][:oversee_datatype]

      respond_to do |format|
        if @resource.update(resource_params)
          format.html { redirect_to resource_path(@resource.id, resource: @resource_class) }
          format.turbo_stream
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

      @key = params[:key].to_sym
      @value = @resource.send(@key)
      @datatype = @resource.class.columns_hash[@key.to_s].type

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(dom_id(@resource, @key), partial: "oversee/resources/input_field", locals: { datatype: @datatype, key: @key, value: @value })
          ]
        end
      end
    end

    private

    def set_resource_class
      @resource_class = params[:resource].constantize
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
