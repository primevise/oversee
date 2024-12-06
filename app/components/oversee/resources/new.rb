# frozen_string_literal: true

class Oversee::Resources::New < Oversee::Base
  def initialize(resource:, resource_class:, params:)
    @resource = resource
    @resource_class = resource_class
    @params = params
  end

  def around_template
    render Oversee::Layout::Application.new { super }
  end

  def view_template
    render Oversee::Dashboard::Header.new(title: @resource_class.to_s, subtitle: "Creating new record")

    div(class: "p-8") do
      render Oversee::Resources::Form.new(resource: @resource)
    end
  end
end
