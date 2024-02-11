Rails.application.routes.draw do
  # マイページ
  namespace :mypage do
    root to: "home#index"
    resources :users, only: [:show, :update, :edit]
  end

  # アカウント機能
  devise_for :users, controllers: {
    sessions: "users/sessions",
    passwords: "users/passwords",
    registrations: "users/registrations"
  }
  # ルーティング
  root to: "conferences#index"

  # オンラインイベント支援システム
  resources :conferences, only: [:show, :index]
  resources :days, only: [:show]
  resources :slots, only: [:show]
  resources :participations, only: [:create, :destroy]
  # 試し用ページ
  get "home/index"
end
