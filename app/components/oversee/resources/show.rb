# frozen_string_literal: true

class Oversee::Resources::Show < Oversee::Base
  include Phlex::Rails::Helpers::ButtonTo
  include Phlex::Rails::Helpers::TurboFrameTag

  def initialize(resource:, resource_class:, resource_associations:, params:)
    @resource = resource
    @resource_class = resource_class
    @resource_associations = resource_associations
    @params = params
    @oversee_resource = Oversee::Resource.new(resource_class: @resource_class, resource: @resource)
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

      # BELONGS_TO Associations
      if !!belongs_to_associations.length
        belongs_to_associations.each do |association|
          div(class: "py-6") do
            div(class: "space-y-4") do
              div(class:"flex items-center gap-2") do
                render Oversee::Field::Label.new(key: association[:name].to_s.titleize, datatype: :data)
                a(href: helpers.resources_path(resource_class_name: association[:class_name].to_s), class: "hover:text-blue-500") { render Phlex::Icons::Iconoir::ArrowUpRight.new(class: "size-3") }
              end

              div(class: "flex items-center gap-2 flex-wrap") do
                foreign_key_value = @resource[association[:foreign_key]]
                path = !!foreign_key_value ? helpers.resource_path(id: foreign_key_value, resource_class_name: association[:class_name]) : helpers.resources_path(resource_class_name: association[:class_name])

                a(
                  href: path,
                  class:
                    "inline-flex items-center gap-2 text-xs border border-transparent bg-gray-100 hover:bg-gray-200 px-3 py-1.5"
                ) do
                  plain "#{association[:class_name]} | #{foreign_key_value}"
                  span { render Phlex::Icons::Iconoir::ArrowUpRight.new(class: "size-3") }
                end
              end
            end
          end
        end
      end

      # HAS_MANY Associations
      if !!has_many_associations.length
        has_many_associations.each do |association|
          associated_resources = @resource.send(association[:name])
          associated_resource_class = association[:class_name].constantize

          div(class: "py-6") do
            div(class: "space-y-4") do
              div(class:"flex items-center gap-2") do
                render Oversee::Field::Label.new(key: association[:name].to_s.titleize, datatype: :data)
                a(href: helpers.resources_path(resource_class_name: association[:class_name]), class: "hover:text-blue-500") { render Phlex::Icons::Iconoir::ArrowUpRight.new(class: "size-3") }
              end

              div(class: "bg-gray-50 p-2") do
                if associated_resources.present?
                  div(class: "bg-white") do
                    # turbo_frame_tag(
                    #   dom_id(associated_resource_class, :table),
                    #   src: helpers.resources_table_path(
                    #     resource_class_name: association[:class_name],
                    #     filters: { eq: { association[:foreign_key] => [@resource.id] } }
                    #   ),
                    #   loading: :lazy,
                    #   data: { turbo_stream: true }
                    # ) do
                    #   div(class: "h-20 flex items-center justify-center") { render Phlex::Icons::Iconoir::DatabaseSearch.new(class: "animate-pulse size-6 text-gray-600") }
                    # end

                  #
                    render Oversee::Resources::Table.new(
                      resources: associated_resources,
                      resource_class: associated_resource_class,
                      params: @params
                    )
                  end
                else
                  p(class: "bg-gray-50 p-2 pr-4 flex gap-2 items-center text-xs") {
                    render Phlex::Icons::Iconoir::DatabaseSearch.new(class: "size-3")
                    plain "No #{association[:name].to_s.titleize.downcase} found"
                  }
                end
              end
            end
          end
        end
      end
    end
  end

  private

  def belongs_to_associations
    @oversee_resource.associations[:belongs_to]
  end

  def has_many_associations
    @oversee_resource.associations[:has_many]
  end

  def has_associations?
    @resource_associations.present?
  end
end
