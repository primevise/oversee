# frozen_string_literal: true

class Oversee::Resources::Index < Oversee::Base
  def initialize(resources:, resource_class:, pagy:)
    @resources = resources
    @resource_class = resource_class
    @pagy = pagy
  end


  def around_template
    render Oversee::Layout::Application.new { super }
  end

  def view_template
    render Oversee::Dashboard::Header.new do |header|
      header.item do
        render Phlex::Icons::Iconoir::Folder.new(class: "size-4.5 text-gray-400", stroke_width: 1.75)
        header.title { @resource_class.to_s.pluralize }
      end
      header.item do

        render Oversee::Button.new(
          size: :sm,
          kind: :primary,
          href: new_resource_path(params[:resource]),
          target: "_top"
        ) do
          render Phlex::Icons::Iconoir::Plus.new(class: "size-4 text-indigo-100", stroke_width: 2)
          plain "Add new"
        end
      end
    end

    render Oversee::Dashboard::Actions.new

    hr(class: "mt-4")
    render Oversee::Resources::Table.new(resource_class: @resource_class, resources: @resources)
    hr
    render Oversee::Dashboard::Pagination.new(pagy: @pagy)
  end

  private

  def resource_associations
    @resource_class.reflect_on_all_associations.select { |association| association.macro == :belongs_to }
  end
end
