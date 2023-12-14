module Oversee
  class ResourcesController < BaseController
    def index
      @klass = resource_class
      @resources = resource_class.all
    end

    def show
      @klass = resource_class
      @resource = resource_class.find(params[:id])
    end

    private

    def resource_class
      params[:resource].constantize
    end
  end
end
