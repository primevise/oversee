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
            layout_icon
            span { "Dashboard" }
          end
        end
        li do
          link_to helpers.main_app.root_path,
            class:
              "flex items-center gap-2 hover:bg-gray-50 p-2 rounded-lg" do
            main_app_icon
            span { "Return to app" }
          end
        end
      end

      hr(class: "my-4")
      p(class: "text-[0.7rem] uppercase text-gray-400 font-medium mb-2") { "Resources" }
      ul(class: "text-sm text-gray-700") do
        ApplicationRecord.descendants.map(&:to_s).sort.each do |resource_name|
          li do
            link_to helpers.resources_path(resource: resource_name), class: "flex items-center gap-2 hover:bg-gray-50 p-2 rounded-lg" do
              folder_icon
              span { resource_name }
            end
          end
        end
      end

      hr(class: "my-4")
      p(class: "text-xs text-gray-500") do
        plain("Powered by ")
        a(
            href: "https://github.com/primevise/oversee",
            class: "text-blue-500 hover:underline",
            target: "_blank"
          ) { "Oversee" }
      end
    end
  end

  private

  def folder_icon
    svg(
      xmlns: "http://www.w3.org/2000/svg",
      width: "24",
      height: "24",
      viewbox: "0 0 24 24",
      fill: "none",
      stroke: "currentColor",
      stroke_width: "2",
      stroke_linecap: "round",
      stroke_linejoin: "round",
      class: "h-4 w-4 text-gray-400"
    ) do |s|
      s.path(stroke: "none", d: "M0 0h24v24H0z", fill: "none")
      s.path(
        d:
          "M5 4h4l3 3h7a2 2 0 0 1 2 2v8a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2v-11a2 2 0 0 1 2 -2"
      )
    end
  end

  def main_app_icon
    svg(
      xmlns: "http://www.w3.org/2000/svg",
      width: "24",
      height: "24",
      viewbox: "0 0 24 24",
      fill: "none",
      stroke: "currentColor",
      stroke_width: "2",
      stroke_linecap: "round",
      stroke_linejoin: "round",
      class: "h-4 w-4 text-gray-400"
    ) do |s|
      s.path(stroke: "none", d: "M0 0h24v24H0z", fill: "none")
      s.path(d: "M9 21v-6a2 2 0 0 1 2 -2h2c.247 0 .484 .045 .702 .127")
      s.path(d: "M19 12h2l-9 -9l-9 9h2v7a2 2 0 0 0 2 2h5")
      s.path(d: "M16 22l5 -5")
      s.path(d: "M21 21.5v-4.5h-4.5")
    end
  end

  def layout_icon
    svg(
      xmlns: "http://www.w3.org/2000/svg",
      width: "24",
      height: "24",
      viewbox: "0 0 24 24",
      fill: "none",
      stroke: "currentColor",
      stroke_width: "2",
      stroke_linecap: "round",
      stroke_linejoin: "round",
      class: "h-4 w-4 text-gray-400"
    ) do |s|
      s.path(stroke: "none", d: "M0 0h24v24H0z", fill: "none")
      s.path(
        d:
          "M4 4m0 2a2 2 0 0 1 2 -2h2a2 2 0 0 1 2 2v1a2 2 0 0 1 -2 2h-2a2 2 0 0 1 -2 -2z"
      )
      s.path(
        d:
          "M4 13m0 2a2 2 0 0 1 2 -2h2a2 2 0 0 1 2 2v3a2 2 0 0 1 -2 2h-2a2 2 0 0 1 -2 -2z"
      )
      s.path(
        d:
          "M14 4m0 2a2 2 0 0 1 2 -2h2a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-2a2 2 0 0 1 -2 -2z"
      )
    end
  end
end
