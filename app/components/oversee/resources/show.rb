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
    render Oversee::Dashboard::Header.new(title: @resource_class.to_s, subtitle: "##{@resource.id}", return_path: helpers.resources_path(resource_class_name: @params[:resource_class_name])) do
      button_to(helpers.resource_path(resource_class_name: @params[:resource_class_name]), method: :delete, data: { turbo_confirm: "Are you sure?" }, class: "size-8 inline-flex items-center justify-center rounded-full text-rose-500 bg-rose-50 hover:bg-rose-100 text-sm font-medium transition-colors") { render Phlex::Icons::Iconoir::Trash.new(class: "size-4") }
    end

    div(class: "p-8") do
      @resource_class.columns_hash.each do |key, metadata|
        div(class: "py-4") do
          div(class: "space-y-2") do
            render Oversee::Field::Label.new(key: key, datatype: metadata.sql_type_metadata.type)
            div(id: dom_id(@resource, :"#{key}_row"), class: "flex items-center gap-2 mt-4") do
              render Oversee::Field::Display.new(resource: @resource, key: key, datatype: metadata.sql_type_metadata.type)
              # div(id: dom_id(@resource, :"#{key}_actions")) do
              #   div(class: "bg-white text-gray-400 size-9 aspect-square inline-flex items-center justify-center"){ render Phlex::Icons::Iconoir::Copy.new(class: "size-5", stroke_width: 1.75) }
              # end
            end
          end
        end
      end

    if has_associations?
      div(class: "-mx-8") do
        @resource_associations.each do |association|
          associated_resources = Array(@resource.send(association.name.to_sym))
          next if associated_resources.blank?

          foreign_class_name = association.class_name
          foreign_key = association.foreign_key
          foreign_key_value = @resource.send(foreign_key) if @resource.respond_to?(foreign_key)

          div(class: "px-8 py-6") do
            div(class: "space-y-4") do
              div(class:"flex items-center gap-2") do
                render Oversee::Field::Label.new(key: association.name.to_s.titleize, datatype: :data)
                a(href: helpers.resources_path(resource_class_name: association.class_name.to_s), class: "hover:text-blue-500") { render Phlex::Icons::Iconoir::ArrowUpRight.new(class: "size-3") }
              end
              div(class: "flex items-center gap-2 flex-wrap") do
                associated_resources.each do |ar|

                  path = !!foreign_key_value ? helpers.resource_path(id: foreign_key_value, resource_class_name: foreign_class_name) : helpers.resources_path(resource_class_name: foreign_class_name)

                  a(
                    href: path,
                    class:
                      "inline-flex text-xs border border-transparent bg-gray-100 hover:bg-gray-200 px-3 py-1.5"
                  ) do
                    plain "#{ar.class.to_s} | #{ar.to_param}"
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

  def has_associations?
    @resource_associations.present?
  end
end
