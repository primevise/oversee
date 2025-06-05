# frozen_string_literal: true

class Oversee::Components::Dashboard::Sidebar < Oversee::Components::Base
  def view_template
    div(class: "w-60 shrink-0 bg-white h-svh flex flex-col justify-between") do
      div(class: "p-3") do
        p(class: "mb-2 text-[0.6rem] font-medium text-gray-800 uppercase") { "Menu" }
        ul(class: "text-sm text-gray-700") do
          li do
            a(href: root_path, class: "flex items-center gap-2 text-xs text-gray-700 hover:bg-gray-100 transition duration-100 rounded-xs p-1.5") do
              div(class: "size-5 bg-gray-100 flex items-center justify-center") { render Phlex::Icons::Iconoir::ViewGrid.new(class: "size-3 text-gray-700", stroke_width: 1.75) }
              span { "Dashboard" }
            end
          end
          li do
            a(href: main_app.root_path, class: "flex items-center gap-2 text-xs text-gray-700 hover:bg-gray-100 transition duration-100 rounded-xs p-1.5") do
              div(class: "size-5 bg-gray-100 flex items-center justify-center") { render Phlex::Icons::Iconoir::ArrowUpRight.new(class: "size-3 text-gray-700", stroke_width: 1.75) }
              span { "Return to app" }
            end
          end
        end
        render Oversee::Components::Separator.new(class: "my-3 -mx-3")

        p(class: "mb-2 text-[0.6rem] font-medium text-gray-800 uppercase") { "Resources" }

        ul(class: "mt-2 text-sm text-gray-700 overflow-x-hidden") do
          Oversee.application_resource_names.sort.each do |resource|
            li do
              a(href: resources_path(resource:), class: "flex items-center gap-2 text-xs text-gray-700 hover:bg-gray-100 transition duration-100 rounded-xs p-1.5") do
                div(class: "size-5 bg-gray-100 flex items-center justify-center") { render Phlex::Icons::Iconoir::Folder.new(class: "size-3 text-gray-700", stroke_width: 1.75) }
                span { resource }
              end
            end
          end
        end
      end
      div(class: "px-3 h-16 flex items-center justify-center border-t border-gray-950/5") do
        p(class: "text-xs text-gray-700") do
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
end
