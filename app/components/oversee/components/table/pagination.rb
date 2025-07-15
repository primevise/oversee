# frozen_string_literal: true
class Oversee::Components::Table::Pagination < Oversee::Components::Base
  include Pagy::Frontend
  include Phlex::Rails::Helpers::Request

  def initialize(pagy:)
    @pagy = pagy
  end

  def view_template
    div(class: "px-4 py-2 border-t border-gray-950/5") do
      div(class: "flex items-center justify-between") do
        div(class: "font-normal text-[0.6rem]") { raw safe(pagy_info(@pagy)) }
        div(class: "flex items-center gap-4 font-regular") { raw safe(pagy_nav(@pagy)) }
      end
    end
  end

  def render? = @pagy.present?
end
