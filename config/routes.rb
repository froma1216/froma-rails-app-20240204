Rails.application.routes.draw do
  # 管理
  namespace :admin do
    # resources :pawapuro_fielders
    # resources :pawapuro_pitchers
    # resources :pawapuro_players
    namespace :pawapuro do
      resources :players
    end
    resources :pokemon_emerald_factory_participants
    resources :users

    root to: "pokemon_emerald_factory_participants#index"
  end
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

  # 【パワプロ】選手作成メモ
  namespace :pawapuro do
    # `show` アクションの代わりに `details` を利用
    resources :players, except: [:show] do
      # idを含むパス
      member do
        get "details", to: "players#details" # 選手詳細モーダル
      end
    end
  end

  # 【エメラルド】バトルファクトリー参加ポケモン検索
  resources :pokemon_emerald_factory_participants, only: [:index]

  # 【MHXX】クエスト別クリアタイムメモ
  namespace :mhxx do
    resources :quests, only: [:index, :show] do
      collection do
        get "sub_quest_ranks", to: "quests#sub_quest_ranks"
      end
    end
    resources :times, except: [:index, :show] do
      collection do
        get "filtered_weapons", to: "times#filtered_weapons"
        get "filtered_hunter_arts", to: "times#filtered_hunter_arts"
      end
    end
    resources :bookmark_quests, only: [:index, :create, :destroy] do
      collection do
        # 並び替え
        post "update_order", to: "bookmark_quests#update_order"
      end
    end
  end
end
