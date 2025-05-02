# frozen_string_literal: true

class Oversee::Resources::Form < Oversee::Base
  include Phlex::Rails::Helpers::FormWith

  def initialize(record:)
    @record = record
  end

  def view_template
    div(id: dom_id(@record.record)) do
      render Oversee::Resources::Errors.new(resource: @record.record)
      form_with(model: @record.record, url: create_resource_path, scope: :record) do |f|
        resource.columns_for_create.each do |key, metadata|
          p {key}
          div(class: "py-2") do
            render Oversee::Field::Label.new(
                    key: key,
                    datatype: metadata.sql_type_metadata.type
                  )
            div(class: "mt-2") do
              render Oversee::Field::Input.new(
                      key: key,
                      datatype: metadata.sql_type_metadata.type
                    )
            end
          end
        end
        hr(class: "-mx-8 my-8")
        div(class: "flex justify-end mt-8") do
          render Oversee::Button.new(type: :submit) { "Save" }
        end
      end
    end
  end


  private

  def resource
    @resource ||= @record.resource
  end
end
