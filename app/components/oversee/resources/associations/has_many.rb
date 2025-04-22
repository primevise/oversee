# frozen_string_literal: true

class Oversee::Resources::Associations::HasMany < Oversee::Resources::Base
  attr_reader :resource
  attr_reader :associations
  attr_reader :params

  def initialize(resource:, associations:, params:)
    @resource = resource
    @associations = associations
    @params = params
  end

  def view_template
    div(class: "flex flex-col gap-8") do
      associations.each do |association|
        records = resource.send(association[:name])
        associated_resource = association[:class_name].constantize

        div(class: "space-y-4") do
          div(class:"flex items-center gap-2") do
            render Oversee::Field::Label.new(
              key: association[:name].to_s.titleize,
              datatype: :has_many,
              href: resources_path(
                resource: association[:class_name],
                via_resource: resource.class.to_s,
                via_record: resource.to_param,
                association_name: association[:name])
            )
          end

          div(class: "bg-white border border-gray-100 rounded-xs overflow-hidden") do
            # turbo_frame_tag(
            #   dom_id(associated_resource, :table),
            #   src: resources_table_path(resources_table_params(association)),
            #   loading: :lazy,
            #   data: { turbo_stream: true }
            # ) do
            #   div(class: "h-20 flex items-center justify-center") { render Phlex::Icons::Iconoir::DatabaseSearch.new(class: "animate-pulse size-6 text-gray-600") }
            # end

            if records.present?
              div(class: "bg-white") do
                render Oversee::Resources::Table.new(
                  resources: records,
                  resource_class: associated_resource,
                  params: @params
                )
              end
            else
              p(class: "bg-gray-50 p-2 pr-4 flex gap-2 items-center text-sm") do
                render Phlex::Icons::Iconoir::DatabaseSearch.new(class: "size-3")
                plain "No #{association[:name].to_s.titleize.downcase} found"
              end
            end
          end
        end
      end
    end
  end
end
