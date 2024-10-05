//= require jquery3
//= require popper
//= require bootstrap-sprockets
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "@fortawesome/fontawesome-free";
// カスタムjs
import "./pawapuro";
import "./pokemon_emerald_factory_participant";
import "./mhxx";

// containerの高さを設定
document.addEventListener("turbo:load", function () {
  var headerHeight = document.getElementById("navbar").offsetHeight;
  var container = document.getElementById("container");
  container.style.minHeight = `calc(100vh - ${headerHeight}px)`;
});

// bootstrap5のtooltipを有効化
var tooltipTriggerList = [].slice.call(
  document.querySelectorAll('[data-bs-toggle="tooltip"]')
);
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl);
});
