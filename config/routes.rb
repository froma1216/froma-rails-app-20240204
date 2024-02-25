Rails.application.routes.draw do
  # ルーティング
  root to: "home#index"

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

  # オンラインイベント支援システム
  resources :conferences, only: [:show, :index]
  resources :days, only: [:show]
  resources :slots, only: [:show]
  resources :participations, only: [:create, :destroy]

  # パワプロ：選手作成メモ
  resources :pawapuro, except: [:show] do
    collection do
      get "confirm", to: "pawapuro#confirm" # 選手作成確認画面
    end
    #  idを含むパス
    member do
      get "details", to: "pawapuro#details" # 選手詳細モーダル
    end
  end
end
