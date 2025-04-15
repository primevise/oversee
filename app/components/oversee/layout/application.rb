# frozen_string_literal: true

class Oversee::Layout::Application < Oversee::Base

  include Phlex::Rails::Helpers::CSPMetaTag
  include Phlex::Rails::Helpers::CSRFMetaTags
  include Phlex::Rails::Helpers::StylesheetLinkTag
  include Phlex::Rails::Helpers::JavascriptImportmapTags

  def view_template
    doctype
    html do
      # render Head
      head do
        csrf_meta_tags
        csp_meta_tag

        title { "Oversee | #{Oversee.application_name}" }

        meta(name: "viewport", content: "width=device-width, initial-scale=1.0")
        meta(name: "ROBOTS", content: "NOODP")

        link(rel: "stylesheet", type: "text/css", href: "https://unpkg.com/trix@2.1.8/dist/trix.css")

        render Oversee::Dashboard::Javascript.new
        render Oversee::Dashboard::Tailwind.new
      end
      body(class: "bg-white") do
        render Oversee::Flash.new

        div(class: "h-svh") do
          div(class: "h-svh flex flex-col md:flex-row") do
            div(class: "w-72 shrink-0") { render Oversee::Dashboard::Sidebar.new }
            div(class: "border-l border-gray-100 h-svh w-full overflow-y-scroll bg-white") do
              yield if block_given?
            end
          end
        end
      end
    end
  end
end
