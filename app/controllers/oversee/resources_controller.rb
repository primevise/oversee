module Oversee
  class ResourcesController < BaseController
    before_action :set_resource_class, except: [:update]

    def index
      @resources = @resource_class.all
    end

    def show
      @resource = @resource_class.find(params[:id])
    end

    def edit
      @resource = @resource_class.find(params[:id])
    end

    def update
      @resource_class = params[:resource_class].constantize
      @resource = @resource_class.find(params[:id])

      if @resource.update(resource_params)
        redirect_to resource_path(@resource, resource: @resource_class)
      else

      end
    end

    # Non-standard actions
    def input_field
      @resource = @resource_class.find(params[:id])
      @key = params[:key].to_sym
      @value = @resource.send(@key)
      @datatype = @resource.class.columns_hash[@field.to_s].type
      
      # TODO Turbo response for an input field partial
    end

    private

    def set_resource_class
      @resource_class = params[:resource].constantize
    end

    def resource_params
      params.require(:resource).permit!
    end
  end
end
