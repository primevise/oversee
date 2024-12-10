# frozen_string_literal: true
class Oversee::Dashboard::Filters < Oversee::Base
  def view_template
    div(id: :oversee_filters, class: "hidden pt-4 mt-4 border-t flex flex-col gap-2") do
      render Oversee::Dashboard::Filter.new
    end
  end
end
