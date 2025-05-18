# frozen_string_literal: true

class Oversee::Components::Resource::Errors < Oversee::Components::Base
  def initialize(resource: nil, errors: nil, content: nil, **options)
    @resource = resource
    @errors = errors
    @content = content
    @options = options
  end

  def view_template
    if @content || @resource&.errors&.any?
      div(class: container_class) do
        div(class: "inline-flex items-center gap-1.5 bg-red-600 py-1 px-2 text-xs text-white") do
          # render Phlex::TablerIcons::ExclamationCircle.new(class: "size-5", stroke_width: 1.75)
          h3(class: "text-sm font-medium") { plain @content || "Something went wrong!" }
        end
        if displayed_errors.present?
          div(class: "mt-4 border-l-2 border-red-600 p-2") do
            ul(class: "space-y-1 text-sm text-gray-700") do
              displayed_errors.each do |message|
                li { "— #{message}" }
              end
            end
          end
        end
      end
    end
  end

  private

  def container_class
    @options[:container_class] || "bg-white mb-4"
  end

  def displayed_errors
    @errors || @resource&.errors&.full_messages
  end

end
