# frozen_string_literal: true

class Oversee::Components::Resource::Table < Oversee::Components::Base
  include Phlex::Rails::Helpers::TurboFrameTag

  def initialize(resources:, resource_class:, **options)
    @resources = resources
    @resource_class = resource_class || resources.first.class
    @options = options

    @oversee_resource = Oversee::Resource.new(resource_class: @resource_class)
  end

  def view_template
    turbo_frame_tag dom_id(@resource_class, :table), target: "_top" do
      div(class: "w-full overflow-x-scroll") do
        render Oversee::Components::Table.new do |table|
          # Head
          table.head do
            # Actions
            table.column(title: "Actions", class: "first:border-l-0 border-r last:border-r-0 border-gray-950/5") { span(class: "sr-only") {"Resource actions"} }

            # Attributes
            @resource_class.columns_hash.each do |key, metadata|
              next if @oversee_resource.foreign_keys.include?(key.to_s)
              table.column(title: key.humanize, class: "first:border-l-0 border-r last:border-r-0 border-gray-950/5") do
                a(
                  href:
                    (
                      resources_path(
                        resource: params[:resource],
                        sort_attribute: key,
                        sort_direction:
                          params[:sort_direction] == "asc" ? :desc : :asc
                      )
                    ),
                  target: "_top",
                  class: "w-64 flex items-center justify-between gap-2 w-full h-full hover:text-gray-900 transition-colors"
                ) do
                  render Oversee::Components::Field::Label.new(key: key, datatype: metadata.sql_type_metadata.type)
                  render Phlex::Icons::Iconoir::ArrowSeparateVertical.new(class: "size-3 text-gray-500", stroke_width: 2.5)
                end
              end
            end

            # Associations
            resource_associations.each do |association|
              table.column(title: association.name.to_s.humanize, class: "first:border-l-0 border-r last:border-r-0 border-gray-950/5") do
                span(
                  class: "flex items-center justify-between gap-2 w-full h-full hover:text-gray-900 transition-colors"
                ) do
                  render Oversee::Components::Field::Label.new(key: association.name, datatype: nil)
                end
              end
            end
          end

          # Body
          table.body do
            @resources.each do |resource|
              table.row do
                # Actions
                table.cell(class: "first:border-l-0 border-r last:border-r-0 border-gray-950/5") do
                  div(class: "flex space-x-2 mx-4") do
                    a(
                      href:
                        (
                          resource_path(
                            resource.id,
                            resource: @resource_class
                          )
                        ),
                      data: { turbo_stream: true },
                      class: "size-6 bg-gray-100 inline-flex items-center justify-center hover:bg-gray-200"
                    ) { render Phlex::Icons::Iconoir::ArrowUpRight.new(class: "size-3.5 text-gray-400") }
                  end
                end

                # Attributes
                @resource_class.columns_hash.each do |key, metadata|
                  next if @oversee_resource.foreign_keys.include?(key.to_s)
                  table.cell(class: "first:border-l-0 border-r last:border-r-0 border-gray-950/5") do
                    div(class: "min-w-24 max-w-96") do
                      render Oversee::Components::Field::Value.new(key:, datatype: metadata.sql_type_metadata.type, value: resource.send(key), for_table: true)
                    end
                  end
                end

                # Associations
                resource_associations.each do |association|
                  foreign_id = resource.send(association.foreign_key)
                  # resource_class_name = association.class_name

                  path = !!foreign_id ? resource_path(id: foreign_id, resource: association.class_name) : resources_path(resource: association.class_name)

                  table.cell(class: "first:border-l-0 border-r last:border-r-0 border-gray-950/5") do
                    div(class: "w-fit max-w-32") do
                      a(
                        href: path,
                        class:"px-2 py-1 text-xs bg-gray-100 text-gray-500 text-sm flex items-center justify-between gap-2 hover:bg-gray-200 hover:text-gray-900 min-w-20") do
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
  end

  private

  def resource_associations
    @resource_class.reflect_on_all_associations.select { |association| association.macro == :belongs_to }
  end
end
