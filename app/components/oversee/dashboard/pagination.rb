# frozen_string_literal: true
class Oversee::Dashboard::Pagination < Oversee::Base
  include Pagy::Frontend
  include Phlex::Rails::Helpers::Request

  def initialize(pagy:, params:)
    @pagy = pagy
    @params = params
  end

  def view_template
    div(class:"mt-4 flex items-center justify-between") do

      div(class: "font-regular text-xs") do
        raw pagy_info(@pagy).html_safe
      end

      div(class: "flex items-center gap-4") do
        raw pagy_nav(@pagy).html_safe
      end
    end
  end
end
