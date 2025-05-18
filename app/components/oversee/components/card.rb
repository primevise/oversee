class Oversee::Card < Phlex::HTML
  def initialize(card_name:)
    @card_name = card_name
    @card = card_name.constantize.new
  end

  def view_template
    div(class: "bg-gray-100 rounded-md p-4") do
      p(class: "text-xs uppercase text-gray-600") { @card.label }
      h4(class: "mt-2 text-gray-900 text-2xl") { @card.value }
    end
  end
end
