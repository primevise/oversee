# frozen_string_literal: true

class Oversee::Resources::New < Oversee::Base
  include Phlex::Rails::Helpers::FormWith

  def initialize(resource:, resource_class:, params:)
    @resource = resource
    @resource_class = resource_class
    @params = params
  end

  def view_template
    render Oversee::Dashboard::Header.new(title: @resource_class.to_s, subtitle: "Creating new record")
    div(class: "p-8") do
      form_with model: @resource,

                scope: :resource,
                url: helpers.create_resource_path(resource_class: @resource.class),
                scope: :resource do |f|
        div(class: "-mx-8 py-8") do
          @resource_class.columns_hash.each do |key, metadata|
            if [@resource_class.primary_key, "created_at", "updated_at"].include?(key)
              next
            end
            div(class: "px-8 py-2") do
              render Oversee::Field::Label.new(
                      key: key,
                      datatype: metadata.sql_type_metadata.type
                    )
              div(class: "mt-2 w-2/3") do
                render Oversee::Field::Input.new(
                        datatype: metadata.sql_type_metadata.type,
                        key: key
                      )
              end
            end
            # = render Oversee::Fields::DisplayRowComponent.new(key: key, resource: @resource, datatype: metadata.sql_type_metadata.type, value: @resource.send(key))
          end
        end

        div(class: "flex justify-end mt-8") do
          plain f.submit "Save",
                        class:
                          "bg-blue-500 px-4 py-2 rounded-md text-white text-sm hover:bg-blue-600 hover:cursor-pointer"
        end
      end
    end
  end
end
