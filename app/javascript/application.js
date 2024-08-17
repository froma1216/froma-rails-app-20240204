//= require jquery3
//= require popper
//= require bootstrap-sprockets
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@fortawesome/fontawesome-free"

// containerの高さを設定
document.addEventListener("turbo:load", function () {
  var headerHeight = document.getElementById('navbar').offsetHeight;
  var container = document.getElementById('container');
  container.style.minHeight = `calc(100vh - ${headerHeight}px)`;
});
