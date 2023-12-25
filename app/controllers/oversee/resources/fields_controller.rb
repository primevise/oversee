module Oversee
  module Resources
    class FieldsController < BaseController
      before_action :set_resource_class

      def update
        @resource_class = params[:resource_class].constantize
        @resource = @resource_class.find(params[:id])
        # @datatype = @resource_class.columns_hash[@key.to_s].type

        respond_to do |format|
          if @resource.update(resource_params)
            format.html { redirect_to resource_path(@resource, resource: @resource_class) }
            format.turbo_stream
          else
          end
        end
      end
      
      # Non-standard actions
      def edit
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
        @resource_class = params[:resource_class].constantize
      end

      def resource_params
        params.require(:resource).permit!
      end
    end
  end
end
