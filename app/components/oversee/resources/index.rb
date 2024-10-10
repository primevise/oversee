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
      a(href: helpers.new_resource_path(@params[:resource_class_name]), class: "inline-flex items-center justify-center py-2 px-6 rounded-full bg-gray-900 text-white text-sm font-medium") { "Add new" }
    end

    div(class: "bg-white overflow-x-hidden") do
      div(class: "-mx-4 overflow-x-auto sm:-mx-6 lg:-mx-8") do
        div(class: "inline-block min-w-full align-middle sm:px-6 lg:px-8") do
          table(class: "min-w-full divide-y divide-gray-300") do
            thead do
              tr(class: "divide-x divide-gray-200") do
                # th(class: "hidden") { input(type: "checkbox", name: "", id: "", class: "mx-4")}
                th(scope: "col", class: "px-4 py-3 text-left text-xs text-gray-900 uppercase")
                @resource_class.columns_hash.each do |key, metadata|
                  th(scope: "col", class: "px-4 py-3 text-left text-xs text-gray-900 uppercase whitespace-nowrap hover:bg-gray-50 transition") do
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
                      class: "hover:underline"
                    ) do
                      render Oversee::Field::Label.new(key: key, datatype: metadata.sql_type_metadata.type)
                    end
                  end
                end
              end
            end
            tbody(class: "divide-y divide-gray-100 bg-white") do
              @resources.each do |resource|
                tr(class: "divide-x divide-gray-100") do
                  td(class: "hidden") do
                    input(type: "checkbox", name: "", id: "", class: "mx-4")
                  end
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
end
