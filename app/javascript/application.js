//= require jquery3
//= require popper
//= require bootstrap-sprockets
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "@fortawesome/fontawesome-free";
// カスタムjs
// TODO: 画面毎に切り出し
import "./controllers/pawapuro/pawapuro";
import "./controllers/poke_em/poke_em";
import "./controllers/mhxx/mhxx";
import "./sortable";

// containerの高さを設定
document.addEventListener("turbo:load", function () {
  var headerHeight = document.getElementById("navbar").offsetHeight;
  var container = document.getElementById("container");
  container.style.minHeight = `calc(100vh - ${headerHeight}px)`;
});

// bootstrap5のtooltipを有効化
document.addEventListener("turbo:load", function () {
  var tooltipTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="tooltip"]')
  );
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
  });
});
