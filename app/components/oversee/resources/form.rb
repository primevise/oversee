# frozen_string_literal: true

class Oversee::Resources::Form < Oversee::Base
  include Phlex::Rails::Helpers::FormWith
  def initialize(resource:)
    @resource = resource
  end

  def view_template
    div(id: dom_id(@resource)) do
      render Oversee::Resources::Errors.new(resource: @resource)
      form_with model: @resource,
                scope: :resource,
                url: helpers.create_resource_path(resource_class_name:),
                scope: :resource do |f|
        @resource.class.columns_hash.each do |key, metadata|
          if [@resource.class.primary_key, "created_at", "updated_at"].include?(key)
            next
          end
          div(class: "py-2") do
            render Oversee::Field::Label.new(
                    key: key,
                    datatype: metadata.sql_type_metadata.type
                  )
            div(class: "mt-2") do
              render Oversee::Field::Input.new(
                      datatype: metadata.sql_type_metadata.type,
                      key: key
                    )
            end
          end
        end
        hr(class: "-mx-8 my-8")
        div(class: "flex justify-end mt-8") do
          plain f.submit "Save",
                        class:
                          "bg-gray-900 px-6 py-2 rounded-full text-white font-medium text-sm hover:bg-gray-700 cursor-pointer"
        end
      end
    end
  end


  private

  def resource_class_name
    @resource.class.to_s
  end
end
