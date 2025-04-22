module Oversee
  class ResourcesController < BaseController
    include ActionView::RecordIdentifier

    before_action :set_resource
    before_action :set_record, only: %i[show edit update destroy]
    before_action :set_records, only: %i[index]

    def index
      @pagy, @records = pagy(@records, limit: params[:per_page] || Oversee.configuration.per_page)

      render Oversee::Resources::Index.new(
        resources: @records,
        resource_class: @resource,
        pagy: @pagy,
        params: params
      ), layout: false
    end

    def new
      @record = @resource.new
      render Oversee::Resources::New.new(
        record: @record,
        resource: @resource,
        params: params
      ), layout: false
    end

    def create
      @resource = @resource.new(resource_params)

      respond_to do |format|
        if @resource.update(resource_params)
          flash.now[:notice] = "Resource was successfully created."
          format.html { redirect_to resource_path(@resource.id, resource_class_name: @resource) }
          format.turbo_stream { redirect_to resource_path(@resource.id, resource_class_name: @resource), status: :see_other }
        else
          format.html { render :new }
          format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@resource), Oversee::Resources::Form.new(resource: @resource)) }
        end
      end
    end

    def show
      render Oversee::Resources::Show.new(
        resource: @record,
        resource_class: @resource,
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
          flash.now[:notice] = "#{@resource.class.to_s.titleize.capitalize.gsub("::"," ")} was successfully updated!"
          format.html { redirect_to resource_path(@resource.id, resource: @resource) }
          format.turbo_stream do
            component = Oversee::Field::Set.new(resource: @resource, datatype:, key:, value: @resource.send(key))
            render turbo_stream: [
              turbo_stream.replace(dom_id(@resource, key), component),
              turbo_stream.replace(:flash, Oversee::Flash)
            ]
          end
        else
        end
      end
    end

    def destroy
      @resource.destroy
      redirect_to resources_path(resource: @resource)
    end

    def association
      @resources = @resource.find(params[:id]).send(params[:association_name])
      @pagy, @resources = pagy(@resources, limit: params[:per_page] || Oversee.configuration.per_page)

      render Oversee::Resources::Index.new(
        resources: @resources,
        resource_class: @resource,
        pagy: @pagy,
        params: params
      )
    end

    def table
      if params[:association_name].present?
        @resources = @resource.find(params[:id]).send(params[:association_name])
      else
        set_records
      end

      component_id = dom_id(@resource, :table)
      component = Oversee::Resources::Table.new(resource_class: @resource, resources: @resources, params: params)

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

    def set_resource
      @resource ||= params[:resource].constantize
    end

    def set_record
      @record = @resource.find(params[:id])
    end

    def set_records
      set_sorting_rules


      @records = if params[:via_resource].present? && params[:via_record].present?
                   params[:via_resource].constantize.find(params[:via_record]).send(params[:association_name])
                 else
                   @resource.all
                 end

      @records = @records.order(@sort_attribute.to_sym => sort_direction)
      @records = Oversee::Filter.new(collection: @records, params:).apply
      @records = Oversee::Search.new(collection: @records, resource_class: @resource, query: params[:query]).call
    end

    def resource_associations
      @resource_associations ||= @resource.reflect_on_all_associations
    end

    def sort_attribute
      @sort_attribute ||= @resource.column_names.include?(params[:sort_attribute]) ? params[:sort_attribute] : "created_at"
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
