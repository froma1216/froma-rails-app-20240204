# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# Bootstrap and Popper.js
pin "bootstrap" # @5.3.2
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8

# Font Awesome
pin "@fortawesome/fontawesome-free", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.5.1/js/all.js"

pin "sortable", to: "app/javascript/sortable.js"
pin "pawapuro", to: "app/javascript/controllers/pawapuro/pawapuro.js"
pin "poke_em", to: "app/javascript/controllers/poke_em/poke_em.js"
pin "mhxx", to: "app/javascript/controllers/mhxx/mhxx.js"
