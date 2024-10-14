class Oversee::Dashboard::Javascript < Phlex::HTML
  def view_template
    script(async: true, src:"https://unpkg.com/es-module-shims/dist/es-module-shims.js")
    script(type: "importmap", data_turbo_track: "reload") do
      raw %({"imports":{"@hotwired/stimulus":"https://unpkg.com/@hotwired/stimulus/dist/stimulus.js","@hotwired/turbo":"https://unpkg.com/@hotwired/turbo","@hotwired/turbo-rails":"https://unpkg.com/@hotwired/turbo-rails"}}).html_safe
    end
    script(type: "module") { raw %(import * as Turbo from "@hotwired/turbo-rails").html_safe }
  end
end
