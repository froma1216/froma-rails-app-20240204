Rails.application.routes.draw do
  # ルーティング
  root to: "conferences#index"
  # オンラインイベント支援システム
  resources :conferences, only: [:show, :index]
  resources :days, only: [:show]
  resources :slots, only: [:show]
  # 試し用ページ
  get "home/index"
end
