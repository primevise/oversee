module Oversee
  class ResourcesController < BaseController
    include ActionView::RecordIdentifier

    before_action :set_resource_class
    before_action :set_resource, only: %i[show edit update destroy]
    before_action :set_resources, only: %i[index]

    def index
      @pagy, @resources = pagy(@resources, limit: params[:per_page] || Oversee.configuration.per_page)

      render Oversee::Resources::Index.new(
        resources: @resources,
        resource_class: @resource_class,
        pagy: @pagy,
        params: params
      ), layout: false
    end

    def new
      @resource = @resource_class.new
      render Oversee::Resources::New.new(
        resource: @resource,
        resource_class: @resource_class,
        params: params
      ), layout: false
    end

    def create
      @resource = @resource_class.new(resource_params)

      respond_to do |format|
        if @resource.update(resource_params)
          format.html { redirect_to resource_path(@resource.id, resource_class_name: @resource_class) }
          format.turbo_stream { redirect_to resource_path(@resource.id, resource_class_name: @resource_class), status: :see_other }
        else
          format.html { render :new }
          format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@resource), Oversee::Resources::Form.new(resource: @resource)) }
        end
      end
    end

    def show
      render Oversee::Resources::Show.new(
        resource: @resource,
        resource_class: @resource_class,
        resource_associations: resource_associations,
        params: params
      ), layout: false
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
            component = Oversee::Field::Set.new(resource: @resource, datatype:, key:, value: @resource.send(key))
            render turbo_stream: turbo_stream.replace(dom_id(@resource, key), component)
          end
        else
        end
      end
    end

    def destroy
      @resource.destroy
      redirect_to resources_path(resource: @resource_class)
    end

    def association
      @resources = @resource_class.find(params[:id]).send(params[:association_name])
      @pagy, @resources = pagy(@resources, limit: params[:per_page] || Oversee.configuration.per_page)

      render Oversee::Resources::Index.new(
        resources: @resources,
        resource_class: @resource_class,
        pagy: @pagy,
        params: params
      )
    end

    def table
      if params[:association_name].present?
        @resources = @resource_class.find(params[:id]).send(params[:association_name])
      else
        set_resources
      end

      component_id = dom_id(@resource_class, :table)
      component = Oversee::Resources::Table.new(resource_class: @resource_class, resources: @resources, params: params)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(component_id, component)
        end
        format.html do
          render component, layout: false
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

    def set_resources
      set_sorting_rules

      @resources = @resource_class.order(@sort_attribute.to_sym => sort_direction)
      @resources = Oversee::Filter.new(collection: @resources, params:).apply
      @resources = Oversee::Search.new(collection: @resources, resource_class: @resource_class, query: params[:query]).call
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
