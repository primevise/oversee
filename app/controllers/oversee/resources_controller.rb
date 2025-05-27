module Oversee
  class ResourcesController < BaseController
    include ActionView::RecordIdentifier

    before_action :set_resource_class
    before_action :set_resource
    before_action :set_record, only: %i[show edit update destroy]
    before_action :set_records, only: %i[index]

    layout false

    def index
      @pagy, @records = pagy(@records, limit: params[:per_page] || Oversee.configuration.per_page)

      render Oversee::Views::Resources::Index.new(
        resources: @records,
        resource_class: @resource_class,
        pagy: @pagy,
      )
    end

    def new
      @record = @resource.new
      render Oversee::Views::Resources::New.new(resource: @resource)
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
          format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@resource), Oversee::Resources::Form.new(record: @resource)) }
        end
      end
    end

    def show
      render Oversee::Views::Resources::Show.new(
        resource: @record,
        resource_class: @resource_class,
        resource_associations: resource_associations
      )
    end

    def edit
    end

    def update
      key = params[:oversee_key]
      datatype = params[:oversee_datatype]

      respond_to do |format|
        if @record.update(resource_params)
          flash.now[:notice] = "#{@resource.class.to_s.titleize.capitalize.gsub("::"," ")} was successfully updated!"
          format.html { redirect_to resource_path(@record.id, resource: @record) }
          format.turbo_stream do
            component = Oversee::Components::Field::Set.new(resource: @record, datatype:, key:, value: @record.send(key))
            render turbo_stream: [
              turbo_stream.replace(dom_id(@record, key), component),
              turbo_stream.replace(:flash, Oversee::Components::Flash)
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

      render Oversee::Views::Resources::Index.new(
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
      component = Oversee::Components::Resource::Table.new(resource_class: @resource, resources: @resources, params: params)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(component_id, component)
        end
        format.html do
          render component
        end
      end
    end

    private

    def set_resource_class
      @resource_class ||= params[:resource].constantize
    end

    def set_resource
      @resource ||= ::Oversee::Resource.new(resource_class: @resource_class)
    end

    def set_record
      @record = @resource_class.find(params[:id])
    end

    def set_records
      set_sorting_rules

      @records = if params[:via_resource].present? && params[:via_record].present?
                   params[:via_resource].constantize.find(params[:via_record]).send(params[:association_name])
                 else
                   @resource_class.all
                 end

      @records = @records.order(@sort_attribute.to_sym => sort_direction)
      @records = Oversee::Filter.new(collection: @records, params:).apply
      @records = Oversee::Search.new(collection: @records, resource_class: @resource, query: params[:query]).call
    end

    def resource_associations
      @resource_associations ||= @resource_class.reflect_on_all_associations
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
      params.dig(:record)&.delete(:oversee_key)
      params.dig(:record)&.delete(:oversee_datatype)
      params.require(:record).permit!
    end
  end
end
