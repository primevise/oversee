# frozen_string_literal: true

class Oversee::Resources::Index < Oversee::Base
  def initialize(resources:, resource_class:, pagy:, params:)
    @resources = resources
    @resource_class = resource_class
    @pagy = pagy
    @params = params
  end


  def around_template
    render Oversee::Layout::Application.new { super }
  end

  def view_template
    render Oversee::Dashboard::Header.new(title: @resource_class.to_s, subtitle: "Index") do
      a(href: helpers.new_resource_path(@params[:resource_class_name]), class: "inline-flex items-center justify-center size-8 rounded-full bg-emerald-100 text-emerald-500 hover:bg-emerald-200 text-sm font-medium") { render Phlex::Icons::Iconoir::Plus.new(class: "size-4 text-emerald-500") }
    end
    render Oversee::Dashboard::Filters.new(params: @params)
    render Oversee::Resources::Table.new(resource_class: @resource_class, resources: @resources, params: @params)
    render Oversee::Dashboard::Pagination.new(pagy: @pagy, params: @params)
  end

  private

  def resource_associations
    @resource_class.reflect_on_all_associations.select { |association| association.macro == :belongs_to }
  end
end
