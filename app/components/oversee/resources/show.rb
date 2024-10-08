# frozen_string_literal: true

class Oversee::Resources::Show < Oversee::Base
  include Phlex::Rails::Helpers::ButtonTo

  def initialize(resource:, resource_class:, resource_associations:, params:)
    @resource = resource
    @resource_class = resource_class
    @resource_associations = resource_associations
    @params = params
  end


  def view_template
    render Oversee::Dashboard::Header.new(title: @resource_class.to_s, subtitle: "##{@resource.id}") do
      button_to(helpers.resource_path(resource_class_name: @params[:resource_class_name]), method: :delete, data: { turbo_confirm: "Are you sure?" }, class: "py-2 px-6 inline-flex border rounded text-rose-500 shadow-sm hover:bg-gray-50 text-sm font-medium") { "Delete" }
    end

    div(class: "p-8") do
      h3(class: "text-lg mb-4") { "Attributes" }
      div(class: "-mx-8") do
        @resource_class.columns_hash.each do |key, metadata|
          div(class: "px-8 py-4 border-b") do
            div(class: "space-y-2") do
              render Oversee::Field::Label.new(key: key, datatype: metadata.sql_type_metadata.type)
              a(id: dom_id(@resource, key), href: helpers.resource_input_field_path(resource_class_name: @resource_class.to_s, key: key), class: "mt-4 bg-gray-100 flex px-4 py-2 hover:bg-gray-200 transition-colors", data: { turbo_stream: true }) do
                render Oversee::Field::Value.new(key: key, value: @resource.send(key), datatype: metadata.sql_type_metadata.type)
              end
            end
          end
        end
      end
    end

    if has_associations?
      div(class: "pb-8") do
        div(class: "px-8") do
          h3(class: "text-xl mb-8") { "Associations" }
          div(class: "border-y divide-y -mx-8") do
            @resource_associations.each do |association|
              associated_resources = @resource.send(association.name.to_sym)
              next if associated_resources.blank?
              associated_resources = [
                associated_resources
              ] unless associated_resources.respond_to?(:each)
              div(class: "px-8 py-6") do
                div(class: "inline-flex items-center gap-2 mb-4") do
                  div(
                    class:
                      "inline-flex items-center justify-center h-6 w-6 bg-gray-50"
                  ) { association_icon }
                  plain association.name.to_s.titleize
                end
                div(class: "flex gap-2 flex-wrap") do
                  associated_resources.each do |ar|
                    a(
                      href: (helpers.resource_path(ar.id, resource: ar.class)),
                      class:
                        "inline-flex text-xs border border-transparent rounded-full bg-gray-100 hover:bg-gray-200 px-3 py-1.5"
                    ) do
                      plain ar.class.to_s
                      plain " - "
                      plain ar.to_param
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

  def association_icon
    svg(
      xmlns: "http://www.w3.org/2000/svg",
      width: "24",
      height: "24",
      viewbox: "0 0 24 24",
      fill: "none",
      stroke: "currentColor",
      stroke_width: "2",
      stroke_linecap: "round",
      stroke_linejoin: "round",
      class: "h-4 w-4"
    ) do |s|
      s.path(stroke: "none", d: "M0 0h24v24H0z", fill: "none")
      s.path(d: "M12 5m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0")
      s.path(d: "M5 19m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0")
      s.path(d: "M19 19m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0")
      s.path(d: "M6.5 17.5l5.5 -4.5l5.5 4.5")
      s.path(d: "M12 7l0 6")
    end
  end

  def has_associations?
    puts @resource_associations.length
    @resource_associations.present?
  end
end
