pin "application", to: "oversee/application.js", preload: true
pin "@hotwired/turbo-rails", to: "https://unpkg.com/@hotwired/turbo-rails"
pin "@hotwired/stimulus", to: "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js"
# pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "trix", to: "https://unpkg.com/trix@2.1.8"
pin "@rails/actiontext", to: "https://unpkg.com/@rails/actiontext@8.0.0"
pin_all_from Oversee::Engine.root.join("app/javascript/oversee/controllers"), under: "controllers", to: "oversee/controllers"


# Stimulus
# pin_all_from Oversee::Engine.root.join("app/javascript/oversee/controllers"), under: "controllers", to: "oversee/controllers"
# pin_all_from File.expand_path("../app/javascript/oversee/controllers", __dir__), under: "controllers", to: "oversee/controllers"
