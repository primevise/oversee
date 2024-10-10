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
      @resource_class.columns_hash.each do |key, metadata|
        div(class: "py-4") do
          div(class: "space-y-2") do
            render Oversee::Field::Label.new(key: key, datatype: metadata.sql_type_metadata.type)
            div(id: dom_id(@resource, :"#{key}_row"), class: "flex items-center gap-2 mt-4") do
              a(id: dom_id(@resource, key), href: helpers.resource_input_field_path(resource_class_name: @resource_class.to_s, key: key), class: "bg-gray-100 h-10 flex px-4 py-2 hover:bg-gray-200 transition-colors w-full cursor-pointer", data: { turbo_stream: true }) do
                render Oversee::Field::Value.new(key: key, value: @resource.send(key), datatype: metadata.sql_type_metadata.type)
              end
              # div(id: dom_id(@resource, :"#{key}_actions")) do
              #   div(class: "bg-white text-gray-400 size-9 aspect-square inline-flex items-center justify-center"){ copy_icon }
              # end
            end
          end
        end
      end
    end

    if has_associations?
      div(class: "px-8") do
        div(class: "_border-y divide-y -mx-8") do
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

  def copy_icon
    svg(
      stroke_width: "1.5",
      viewbox: "0 0 24 24",
      fill: "none",
      xmlns: "http://www.w3.org/2000/svg",
      class: "size-5",
      color: "currentColor"
    ) do |s|
      s.path(
        d:
          "M19.4 20H9.6C9.26863 20 9 19.7314 9 19.4V9.6C9 9.26863 9.26863 9 9.6 9H19.4C19.7314 9 20 9.26863 20 9.6V19.4C20 19.7314 19.7314 20 19.4 20Z",
        stroke: "currentColor",
        stroke_width: "1.5",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
      s.path(
        d:
          "M15 9V4.6C15 4.26863 14.7314 4 14.4 4H4.6C4.26863 4 4 4.26863 4 4.6V14.4C4 14.7314 4.26863 15 4.6 15H9",
        stroke: "currentColor",
        stroke_width: "1.5",
        stroke_linecap: "round",
        stroke_linejoin: "round"
      )
    end
  end

  def has_associations?
    @resource_associations.present?
  end
end
