# frozen_string_literal: true
class Oversee::Components::Dashboard::Filter < Oversee::Components::Base
  def view_template
    div(class: "flex items-center gap-2") do
      render Phlex::Icons::Iconoir::LongArrowDownRight.new(class: "size-4 text-gray-500")
      form(action: "", class: "flex items-center gap-2") do
        input(type: :text, placeholder: "Title [EQ]", name: "filters[title][eq][]", class: "bg-gray-100 px-4 py-2 text-xs")
        button(type: :submit, class: "button", class: "bg-gray-900 text-white px-4 py-2 text-xs font-medium") { plain "Apply" }
      end
    end
  end
end
