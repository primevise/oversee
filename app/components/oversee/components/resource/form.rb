# frozen_string_literal: true

class Oversee::Components::Resource::Form < Oversee::Components::Base
  include Phlex::Rails::Helpers::FormWith

  attr_reader :resource

  def initialize(resource:)
    @resource = resource
  end

  def view_template
    div(id: dom_id(record)) do
      render Oversee::Components::Resource::Errors.new(resource: record)
      form_with(model: record, url: create_resource_path, scope: :record) do |f|
        resource.columns_for_create.each do |key, metadata|
          div(class: "py-2") do
            render Oversee::Components::Field::Label.new(
                    key: key,
                    datatype: metadata.sql_type_metadata.type
                  )
            div(class: "mt-2") do
              render Oversee::Components::Field::Input.new(
                      key: key,
                      datatype: metadata.sql_type_metadata.type
                    )
            end
          end
        end
        hr(class: "-mx-8 my-8")
        div(class: "flex justify-end mt-8") do
          render Oversee::Components::Button.new(type: :submit) { "Save" }
        end
      end
    end
  end

  private

  def record
    @record ||= @resource.record
  end
end
