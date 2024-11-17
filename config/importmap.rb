pin "@hotwired/turbo-rails", to: "https://unpkg.com/@hotwired/turbo-rails"
pin "@hotwired/stimulus", to: "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

pin "application", to: "oversee/application.js", preload: true
pin_all_from Oversee::Engine.root.join("app/javascript/oversee/controllers"), under: "controllers", to: "oversee/controllers"
