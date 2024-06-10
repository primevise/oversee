module Oversee
  class CardComponent < Phlex::HTML
    def initialize(card_name: )
      @card_name = card_name
      @card = card_name.constantize.new
    end

    def view_template
      div(class: "bg-white rounded-md border shadow-sm p-4") do
        p(class: "text-xs uppercase font-medium text-gray-400") { @card.label }
        h4(class: "mt-2 text-gray-900 text-2xl") { @card.value }
      end
    end
  end
end
