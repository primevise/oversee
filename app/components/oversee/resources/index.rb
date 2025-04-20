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
    render Oversee::Dashboard::Header.new do |header|
      header.item do
        header.title { @resource_class.to_s.pluralize }
      end
      header.item do

        render Oversee::Button.new(
          size: :sm,
          kind: :primary,
          href: helpers.new_resource_path(@params[:resource_class_name]),
          target: "_top"
        ) do
          render Phlex::Icons::Iconoir::Plus.new(class: "size-4 text-indigo-100", stroke_width: 2)
          plain "Add new"
        end
      end
    end


    # render Oversee::Dashboard::Header.new(title: @resource_class.to_s.pluralize) do |h|
    #   h.left
    #   h.right do
    #     a(
    #       href: helpers.new_resource_path(@params[:resource_class_name]),
    #       target: "_top",
    #       class: "inline-flex items-center justify-center gap-1.5 h-8 px-4 rounded-full bg-transparent text-gray-900 hover:bg-gray-100 text-sm font-medium transition group"
    #     ) do
    #       render Phlex::Icons::Iconoir::Plus.new(class: "size-4 text-gray-500 group-hover:text-blue-500", stroke_width: 2.5)
    #       plain "Add new"
    #     end
    #   end
    # end
    # hr(class: "my-4")

    render Oversee::Dashboard::Actions.new(params: @params)

    hr(class: "mt-4")
    render Oversee::Resources::Table.new(resource_class: @resource_class, resources: @resources, params: @params)
    hr()
    render Oversee::Dashboard::Pagination.new(pagy: @pagy, params: @params)
  end

  private

  def resource_associations
    @resource_class.reflect_on_all_associations.select { |association| association.macro == :belongs_to }
  end
end
