# frozen_string_literal: true

class Oversee::Resources::Index < Oversee::Base

  def initialize(resources:, resource_class:, pagy:, params:)
    @resources = resources
    @resource_class = resource_class
    @pagy = pagy
    @params = params
  end


  def view_template
    render Oversee::Dashboard::Header.new(title: @resource_class.to_s, subtitle: "Index") do
      a(href: helpers.new_resource_path(@params[:resource_class_name]), class: "inline-flex items-center justify-center size-8 rounded-full bg-emerald-100 text-emerald-500 hover:bg-emerald-200 text-sm font-medium") { plus_icon }
    end

    render Oversee::Dashboard::Filters.new(params: @params)

    div(class: "bg-white overflow-x-hidden") do
      div(class: "-mx-4 overflow-x-auto sm:-mx-6 lg:-mx-8") do
        div(class: "inline-block min-w-full align-middle sm:px-6 lg:px-8") do
          table(class: "min-w-full divide-y divide-gray-200") do
            thead do
              tr(class: "divide-x divide-gray-200") do
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
                      sort_icon
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
            tbody(class: "divide-y divide-gray-200 bg-white") do
              @resources.each do |resource|
                tr(class: "divide-x divide-gray-200") do
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
                      ) { eye_icon }
                    end
                  end
                  @resource_class.columns_hash.each do |key, metadata|
                    td(class: "whitespace-nowrap p-4 text-sm text-gray-500") do
                      div(class: "max-w-96") do
                        render Oversee::Field::Value.new(datatype: metadata.sql_type_metadata.type, value: resource.send(key), key: key)
                      end
                    end
                  end
                  resource_associations.each do |association|
                    td(class: "whitespace-nowrap p-4 text-sm text-gray-500") do
                      div(class: "max-w-96") do
                        span(class:"px-2 py-1 rounded-full bg-gray-100 text-gray-500 text-xs") do
                          # plain "#{association.class_name} | #{resource.send(association.name).to_param}"
                          plain "#{association.class_name}"
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

    render raw(pagy_nav(@pagy)) if @pagy.pages > 1
  end

  private

  def resource_associations
    @resource_class.reflect_on_all_associations.select { |association| association.macro == :belongs_to }
  end

  def eye_icon
    svg(
      xmlns: "http://www.w3.org/2000/svg",
      viewbox: "0 0 16 16",
      fill: "currentColor",
      data_slot: "icon",
      class: "w-4 h-4 text-gray-500 group-hover:text-black"
    ) do |s|
      s.path(d: "M8 9.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3Z")
      s.path(
        fill_rule: "evenodd",
        d:
          "M1.38 8.28a.87.87 0 0 1 0-.566 7.003 7.003 0 0 1 13.238.006.87.87 0 0 1 0 .566A7.003 7.003 0 0 1 1.379 8.28ZM11 8a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z",
        clip_rule: "evenodd"
      )
    end
  end

  def plus_icon
    svg(
      stroke_width: "2",
      viewbox: "0 0 24 24",
      fill: "none",
      xmlns: "http://www.w3.org/2000/svg",
      color: "currentColor",
      class: "size-4"
    ) do |s|
      s.path(
        d: "M6 12H12M18 12H12M12 12V6M12 12V18",
        stroke: "currentColor",
        stroke_width: "2",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
    end
  end

  def sort_icon
    svg(
      viewbox: "0 0 24 24",
      stroke_width: "2.5",
      fill: "none",
      xmlns: "http://www.w3.org/2000/svg",
      color: "currentColor",
      class: "size-3 text-gray-500"
    ) do |s|
      s.path(
        d: "M17 8L12 3L7 8",
        stroke: "currentColor",
        stroke_width: "2.5",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
      s.path(
        d: "M17 16L12 21L7 16",
        stroke: "currentColor",
        stroke_width: "2.5",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
    end
  end
end
