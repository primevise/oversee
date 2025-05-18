class Oversee::Components::Dashboard::Javascript < Phlex::HTML
  include Phlex::Rails::Helpers::JavascriptImportmapTags

  def view_template
    script(async: true, src:"https://ga.jspm.io/npm:es-module-shims@1.8.2/dist/es-module-shims.js")
    javascript_importmap_tags("application", importmap: Oversee.importmap)
    script(type: "module") { raw turbo_script.html_safe }
  end

  private

  def turbo_script
    <<~JAVASCRIPT
      import * as Turbo from "@hotwired/turbo-rails"
    JAVASCRIPT
  end
end
