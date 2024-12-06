# frozen_string_literal: true

class Oversee::Dashboard::Index < Oversee::Base

  def around_template
    render Oversee::Layout::Application.new { super }
  end

  def view_template
    div(class: "flex items-center justify-between") do
      div do
        p(class: "text-xs uppercase font-medium text-gray-400") { "Dashboard" }
        h1(class: "text-xl") { "Welcome" }
      end
    end

    if Oversee.card_class_names.present?
      div(class: "grid grid-cols-4 gap-4") do
        Oversee.card_class_names.each do |card_name|
          render Oversee::Card.new(card_name: card_name)
        end
      end
    end

    hr(class: "my-4")

    div(class: "grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4") do
      Oversee.application_resource_names.sort.each do |resource_class_name|
          a(href: helpers.resources_path(resource_class_name:), class: "w-full bg-gray-100/75 block hover:bg-gray-50 p-4 truncate") do
            div(class: "flex items-center justify-center size-8 bg-white") do
              render Phlex::Icons::Iconoir::Folder.new(class: "size-4 text-gray-400")
            end
            p(class: "mt-4 font-medium text-gray-700") { resource_class_name }
          end
      end
    end
  end
end
