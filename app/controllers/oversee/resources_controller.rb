module Oversee
  class ResourcesController < BaseController
    before_action :set_resource_class, except: [:update]
    before_action :set_resource, only: %i[show edit destroy]

    def index
      @pagy, @resources = pagy(@resource_class.all)
    end

    def show
    end

    def edit
    end

    def update
      @resource_class = params[:resource_class].constantize
      set_resource
      # @datatype = @resource_class.columns_hash[@key.to_s].type

      respond_to do |format|
        if @resource.update(resource_params)
          format.html { redirect_to resource_path(@resource, resource: @resource_class) }
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
      @resource = @resource_class.find(params[:id])
      @key = params[:key].to_sym
      @value = @resource.send(@key)
      @datatype = @resource.class.columns_hash[@key.to_s].type
      puts "---"
      puts "key: #{@key}"
      puts "value: #{@value}"
      puts "datatype: #{@datatype}"
      puts "---"
    end

    private

    def set_resource_class
      @resource_class = params[:resource].constantize
    end

    def set_resource
      @resource = @resource_class.find(params[:id])
    end

    def resource_params
      params.require(:resource).permit!
    end
  end
end
