# frozen_string_literal: true
class Oversee::Components::Dashboard::Pagination < Oversee::Components::Base
  include Pagy::Frontend
  include Phlex::Rails::Helpers::Request

  def initialize(pagy:)
    @pagy = pagy
  end

  def view_template
    div(class:"mt-4 flex items-center justify-between px-4") do

      div(class: "font-regular text-xs") do
        raw pagy_info(@pagy).html_safe
      end

      div(class: "flex items-center gap-4") do
        raw pagy_nav(@pagy).html_safe
      end
    end
  end
end
