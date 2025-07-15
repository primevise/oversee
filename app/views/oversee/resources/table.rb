class Oversee::Views::Resources::Table < Oversee::Views::Base
  attr_reader :resources, :resource_class, :pagy

  def initialize(resources:, resource_class:, pagy:)
    @resources = resources
    @resource_class = resource_class
    @pagy = pagy
  end

  def view_template
    if resources.any?
      render Oversee::Components::Resource::Table.new(resource_class:, resources:, pagy:)
    else
      render Oversee::Components::TurboFrame.new(id: dom_id(resource_class, :table)) do
        div(class: "flex flex-col justify-center p-2") do
          div(class: "flex items-center gap-4") do
            div(class:"size-8 bg-gray-950/5 inline-flex items-center justify-center") do
              render Phlex::Icons::Iconoir::DatabaseSearch.new(class: "size-6 text-gray-500")
            end
            div do
              p(class: "text-xs font-medium text-gray-700") { "No records found" }
              p(class: "text-[0.6rem] text-gray-400") { "Try adjusting your search criteria" }
            end
          end
        end
      end
    end
  end
end
