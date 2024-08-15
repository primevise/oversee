# frozen_string_literal: true

class Oversee::Dashboard::SidebarComponent < ApplicationComponent
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::ButtonTo

  def view_template
    div(class: "bg-white border p-4 rounded-lg") do

      p(class: "text-[0.7rem] uppercase text-gray-400 font-medium mb-2") { "Menu" }
      ul(class: "text-sm text-gray-700") do
        li do
          link_to root_path,
            class:
              "flex items-center gap-2 hover:bg-gray-50 p-2 rounded-lg" do
            # render Phlex::TablerIcons::Wallet.new(classes: "text-gray-500 h-5 w-5")
            span { "Dashboard" }
          end
        end
        li do
          link_to helpers.main_app.root_path,
            class:
              "flex items-center gap-2 hover:bg-gray-50 p-2 rounded-lg" do
            # render Phlex::TablerIcons::Briefcase.new(classes: "text-gray-500 h-5 w-5")
            span { "Return to app" }
          end
        end
      end

      hr(class: "my-4")
      p(class: "text-[0.7rem] uppercase text-gray-400 font-medium mb-2") { "Resources" }
      ul(class: "text-sm text-gray-700") do
        ApplicationRecord.descendants.map(&:to_s).sort.each do |resource_name|
          li do
            link_to root_path,
              class:
                "flex items-center gap-2 hover:bg-gray-50 p-2 rounded-lg" do
              # render Phlex::TablerIcons::Briefcase.new(classes: "text-gray-500 h-5 w-5")
              span { resource_name }
            end
          end
        end
      end

      hr(class: "my-4")
      p(class: "text-xs") do
        plain("Powered by ")
        a(
            href: "https://github.com/primevise/oversee",
            class: "text-blue-500 hover:underline",
            target: "_blank"
          ) { "Oversee" }
      end
    end
  end
end
