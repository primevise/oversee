# frozen_string_literal: true

class Oversee::Dashboard::Index < Oversee::Base

  def around_template
    render Oversee::Layout::Application.new { super }
  end

  def view_template

    render Oversee::Dashboard::Header.new do |header|
      header.item do
        header.title { "Dashboard" }
      end
      header.item do
        p(class: "text-gray-500") { Date.current.to_fs(:long) }

      end
    end

    if Oversee.card_class_names.present?
      div(class: "grid grid-cols-4 gap-4") do
        Oversee.card_class_names.each do |card_name|
          render Oversee::Card.new(card_name: card_name)
        end
      end
    end


    div(class: "p-4") do
      div(class: "grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-4") do
        Oversee.application_entity_names.sort.each do |entity|
            a(href: helpers.resources_path(entity:), class: "w-full bg-gray-100/75 block hover:bg-gray-50 p-4 truncate rounded-xs") do
              div(class: "flex items-center justify-center size-8 bg-white") do
                render Phlex::Icons::Iconoir::Folder.new(class: "size-4 text-gray-400")
              end
              p(class: "mt-4 font-medium text-gray-700") { entity }
            end
        end
      end
    end
  end
end
