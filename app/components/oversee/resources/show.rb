# frozen_string_literal: true

class Oversee::Resources::Show < Oversee::Base
  include Phlex::Rails::Helpers::ButtonTo
  include Phlex::Rails::Helpers::TurboFrameTag

  attr_reader :resource
  attr_reader :resource_class
  attr_reader :resource_associations

  def initialize(resource:, resource_class:, resource_associations:, params:)
    @resource = resource
    @resource_class = resource_class
    @resource_associations = resource_associations
    @params = params

    @oversee_resource = Oversee::Resource.new(resource_class: @resource_class, instance: @resource)
  end


  def view_template
    render Oversee::Dashboard::Header.new(title: @resource_class.to_s, subtitle: "##{@resource.id}", return_path: helpers.resources_path(resource_class_name: @params[:resource_class_name])) do
      button_to(helpers.resource_path(resource_class_name: @params[:resource_class_name]), method: :delete, data: { turbo_confirm: "Are you sure?" }, class: "size-8 inline-flex items-center justify-center rounded-full text-rose-500 bg-rose-50 hover:bg-rose-100 text-sm font-medium transition-colors") { render Phlex::Icons::Iconoir::Trash.new(class: "size-4") }
    end

    div(class: "p-8") do
      @resource_class.columns_hash.each do |key, metadata|
        next if @oversee_resource.foreign_keys.include?(key.to_s)

        div(class: "py-4") do
          div(class: "space-y-2") do
            render Oversee::Field::Label.new(key: key, datatype: metadata.sql_type_metadata.type)
            div(id: dom_id(@resource, :"#{key}_row"), class: "flex items-center gap-2 mt-4") do
              render Oversee::Field::Display.new(resource:, key:, value: @resource.send(key), datatype: metadata.sql_type_metadata.type)
              # div(id: dom_id(@resource, :"#{key}_actions")) do
              #   button(class: "bg-gray-100 hover:bg-gray-200 text-gray-400 hover:text-blue-500 size-10 aspect-square inline-flex items-center justify-center transition-colors") { render Phlex::Icons::Iconoir::Copy.new(class: "size-4") }
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

              foreign_key = association[:foreign_key]
              foreign_key_value = @resource[association[:foreign_key]]
              path = !!foreign_key_value ? helpers.resource_path(id: foreign_key_value, resource_class_name: association[:class_name]) : helpers.resources_path(resource_class_name: association[:class_name])

              div(id: dom_id(@resource, :"#{foreign_key}_row"), class: "flex items-center gap-2 mt-4") do
                render Oversee::Field::Display.new(resource:, key: foreign_key, value: foreign_key_value, datatype: :belongs_to, display_key: true)
                div(id: dom_id(@resource, :"#{foreign_key}_actions")) do
                  a(href: path, class: "bg-gray-100 hover:bg-gray-200 text-gray-400 hover:text-blue-500 size-10 aspect-square inline-flex items-center justify-center transition-colors"){ render Phlex::Icons::Iconoir::ArrowUpRight.new(class: "size-4") }
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
                # turbo_frame_tag(
                #   dom_id(associated_resource_class, :table),
                #   src: helpers.resources_table_path(resources_table_params(association)),
                #   loading: :lazy,
                #   data: { turbo_stream: true }
                # ) do
                #   div(class: "h-20 flex items-center justify-center") { render Phlex::Icons::Iconoir::DatabaseSearch.new(class: "animate-pulse size-6 text-gray-600") }
                # end

                if associated_resources.present?
                  div(class: "bg-white") do
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

  def resources_table_params(association)
    # if association[:through].nil?
    #   return { association[:foreign_key] => { eq: [@resource.id] } }
    # else
    #   keys = @resource.send(association[:through]).pluck(association[:foreign_key])
    #   return { @resource_class.primary_key => { eq: keys } }
    # end

    {
      resource_class_name: association[:class_name],
      association_name: association[:through],
      filters: { association[:foreign_key] => { eq: [@resource.id] } }
    }
  end
end
