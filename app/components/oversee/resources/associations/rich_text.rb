# frozen_string_literal: true

class Oversee::Resources::Associations::RichText < Oversee::Resources::Base
  attr_reader :resource
  attr_reader :associations

  def initialize(resource:, associations:)
    @resource = resource
    @associations = associations
  end

  def view_template
    return unless !!associations

    associations.each do |association|
      # Remove the "rich_text_" prefix from the association name
      key = association[:name].to_s[10..].to_sym

      div(id: dom_id(resource, key), class:"flex flex-col gap-2") do
        div(class:"flex items-center justify-between h-10 gap-4") do
          div(class:"flex items-center gap-2") do
            render Oversee::Field::Label.new(
              key: key.to_s.titleize,
              datatype: :rich_text,
              href: resources_path(resource_class_name: association[:class_name].to_s)
            )
          end
        end

        div(id: dom_id(resource, :"#{key.to_s}_row"), class: "flex items-center gap-2") do
          render Oversee::Field::Display.new(resource:, key:, value: @resource.send(key).to_plain_text[..196], datatype: :rich_text)
        end
      end
    end
  end
end
