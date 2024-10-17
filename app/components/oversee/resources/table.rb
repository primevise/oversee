# frozen_string_literal: true

class Oversee::Resources::Table < Oversee::Base
  include Phlex::Rails::Helpers::TurboFrameTag

  def initialize(resources:, resource_class:, params:, **options)
    @resources = resources
    @resource_class = resource_class || resources.first.class
    @params = params
    @options = options
  end

  def view_template
    turbo_frame_tag dom_id(@resource_class, :table), target: :_top do
      render Oversee::Table.new do |table|
        table.head do |head|
          head.row do
            th(scope: "col", class: "px-4 py-3 text-left text-xs text-gray-900 uppercase")
            # Attributes
            @resource_class.columns_hash.each do |key, metadata|
              th(scope: "col", class: "text-left text-xs text-gray-900 uppercase whitespace-nowrap hover:bg-gray-50 transition relative") do
                a(
                  href:
                    (
                      helpers.resources_path(
                        resource: @params[:resource],
                        sort_attribute: key,
                        sort_direction:
                          @params[:sort_direction] == "asc" ? :desc : :asc
                      )
                    ),
                  class: "px-4 py-3 flex items-center justify-between gap-2 w-full h-full hover:text-gray-900 transition-colors"
                ) do
                  render Oversee::Field::Label.new(key: key, datatype: metadata.sql_type_metadata.type)
                  render Phlex::Icons::Iconoir::ArrowSeparateVertical.new(class: "size-3 text-gray-500", stroke_width: 2.5)
                end
              end
            end

            # Associations
            resource_associations.each do |association|
              th(scope: "col", class: "text-left text-xs text-gray-900 uppercase whitespace-nowrap hover:bg-gray-50 transition relative") do
                span(
                  class: "px-4 py-3 flex items-center justify-between gap-2 w-full h-full hover:text-gray-900 transition-colors"
                ) do
                  render Oversee::Field::Label.new(key: association.name, datatype: nil)
                end
              end
            end
          end
        end

        table.body do |body|
          @resources.each do |resource|
            body.row do |row|
              td do
                div(class: "flex space-x-2 mx-4") do
                  a(
                    href:
                      (
                        helpers.resource_path(
                          resource.id,
                          resource_class_name: @params[:resource_class_name]
                        )
                      ),
                    data: { turbo_stream: true },
                    class: "size-6 bg-gray-100 inline-flex items-center justify-center hover:bg-gray-200 group"
                  ) { render Phlex::Icons::Iconoir::Eye.new(class: "size-4 text-gray-500") }
                end
              end

              @resource_class.columns_hash.each do |key, metadata|
                row.data do
                  div(class: "max-w-96") do
                    render Oversee::Field::Value.new(datatype: metadata.sql_type_metadata.type, value: resource.send(key), key: key)
                  end
                end
              end

              resource_associations.each do |association|
                foreign_id = resource.send(association.foreign_key)
                resource_class_name = association.class_name

                path = !!foreign_id ? helpers.resource_path(id: foreign_id, resource_class_name:) : helpers.resources_path(resource_class_name: resource_class_name)

                row.data do
                  div(class: "max-w-96") do
                    a(
                      href: path,
                      class:"px-2 py-1 bg-gray-100 text-gray-500 text-sm flex items-center justify-between gap-2 hover:bg-gray-200 hover:text-gray-900 min-w-20") do
                      span { foreign_id.presence || "N/A" }
                      render Phlex::Icons::Iconoir::ArrowRight.new(class: "size-3")
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  private

  def resource_associations
    @resource_class.reflect_on_all_associations.select { |association| association.macro == :belongs_to }
  end
end
