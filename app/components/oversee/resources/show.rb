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

    @oversee_resource = Oversee::Resource.new(klass: @resource_class)
  end

  def around_template
    render Oversee::Layout::Application.new { super }
  end

  def view_template
    render Oversee::Dashboard::Header.new do |header|
      header.item do
        header.title { @resource_class.to_s.pluralize }
        div(class: "inline-flex items-center justify-center gap-1 text-sm bg-gray-100 text-gray-600 h-6 px-2 rounded-xs min-w-10 w-fit") do
          render Phlex::Icons::Iconoir::Hashtag.new(class: "size-2.5 text-gray-500", stroke_width: 2)
          span { @resource.to_param }
        end
      end
      header.item do
        # render Oversee::Button.new(size: :sm, kind: :primary, href: new_entry_path(client_id: client.id, modal: true), data: { turbo_frame: :modal }) do
        #   render Phlex::Icons::Iconoir::Plus.new(class: "size-4 text-indigo-100", stroke_width: 2)
        #   plain "Add new entry"
        # end
      end
    end
    # render Oversee::Dashboard::Header.new(title: @resource_class.to_s.pluralize) do |h|
    #   h.left do
    #     h.separator
    #     div(class: "inline-flex items-center gap-1 text-sm bg-gray-100 text-gray-600 h-6 px-2") do
    #       render Phlex::Icons::Iconoir::Hashtag.new(class: "size-2.5 text-gray-500", stroke_width: 2)
    #       span { @resource.to_param }
    #     end
    #   end
    #   h.right do
    #     details(class: "relative inline-block") do
    #       summary(class: "cursor-pointer list-none") do
    #         div(class: "inline-flex items-center justify-center size-8 hover:bg-indigo-50 transition") do
    #           render Phlex::Icons::Iconoir::MoreHorizCircle.new(class: "size-4 text-gray-500")
    #         end
    #       end
    #       ul(
    #         class:
    #           "absolute p-2 mt-2 right-0 top-full min-w-40 overflow-hidden rounded-lg bg-white border border-b-2 border-gray-200/75 divide-y text-xs text-gray-500 font-medium"
    #       ) do
    #         li(class: "w-full") do
    #           button_to(helpers.resource_path(resource_class_name: @params[:resource_class_name]), method: :delete, data: { turbo_confirm: "Are you sure?" }, class: "p-1 hover:bg-gray-50 w-full flex items-center gap-2 transition duration-100") do
    #             div(class: "inline-flex items-center justify-center size-6 bg-gray-100") do
    #               render Phlex::Icons::Iconoir::Trash.new(class: "size-3 text-gray-500")
    #             end
    #             plain "Delete"
    #           end
    #         end
    #       end
    #     end
    #   end
    # end

    div(class: "p-4") do
    # COLUMNS
    div(class: "flex flex-col gap-4") do
      @resource_class.columns_hash.each do |key, metadata|
        next if @oversee_resource.foreign_keys.include?(key.to_s)
        render Oversee::Field::Set.new(resource:, key:, value: @resource.send(key), datatype: metadata.sql_type_metadata.type)
      end
    end


    # RICH TEXT Associations
    if !!rich_text_associations.length
      hr(class: "my-4")
      render Oversee::Resources::Associations::RichText.new(resource:, associations: rich_text_associations)
    end

    # BELONGS_TO Associations
    if !!belongs_to_associations.length
      belongs_to_associations.each do |association|
        div(class: "py-6") do
          div(class: "space-y-4") do
            div(class:"flex items-center gap-2") do
              render Oversee::Field::Label.new(
                key: association[:name].to_s.titleize,
                datatype: :data,
                href: helpers.resources_path(resource_class_name: association[:class_name].to_s)
              )
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

    hr(class: "my-4")

    # HAS_MANY Associations
    render Oversee::Resources::Associations::HasMany.new(resource:, associations: has_many_associations, params: @params) if !!has_many_associations.length
    end
  end

  private

  def rich_text_associations
    @rich_text_associations ||= @oversee_resource.rich_text_associations
  end

  def belongs_to_associations
    @belongs_to_associations ||= @oversee_resource.associations[:belongs_to]
  end

  def has_many_associations
    @has_many_associations ||= @oversee_resource.associations[:has_many]
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
