# frozen_string_literal: true

class Oversee::Dashboard::Index < Oversee::Base
  def view_template
    div(class: "p-8") do
      div(class: "flex items-center justify-between") do
        div do
          p(class: "text-xs uppercase font-medium text-gray-400") { "Dashboard" }
          h1(class: "text-xl") { "Welcome" }
        end
      end
    end

    if Oversee.card_class_names.present?
      div(class: "p-8") do
        div(class: "grid grid-cols-4 gap-4") do
          Oversee.card_class_names.each do |card_name|
            render Oversee::Card.new(card_name: card_name)
          end
        end
      end
    end
  end
end
