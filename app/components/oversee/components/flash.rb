# frozen_string_literal: true

class Oversee::Components::Flash < Phlex::HTML
  include Phlex::Rails::Helpers::Flash

  def view_template
    div(id: :flash, class: "fixed bottom-0 right-0 mb-8 mr-8 w-80 z-50") do
      if !flash.empty?
        div(
          class: "flex flex-col gap-2 p-4 bg-white border border-gray-200/75 border-b-2 rounded-lg transition-all opacity-0 transform duration-300",
          data: { controller: :notification }
        ) do
          notice if notice?
          alert if alert?
        end
      end
    end
  end

  private

  def notice?
    flash[:notice].present?
  end

  def notice
    render Phlex::Icons::Iconoir::CheckCircle.new(class: "size-5 text-emerald-500", stroke_width: 2)
    p(class: "text-sm text-gray-700") { flash[:notice] }
  end

  def alert?
    flash[:alert].present?
  end

  def alert
    render Phlex::Icons::Iconoir::MessageAlert.new(class: "size-5 text-red-500", stroke_width: 2)
    p(class: "text-sm text-gray-700") { flash[:alert] }
  end
end
