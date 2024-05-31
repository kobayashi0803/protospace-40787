
Rails.application.routes.draw do
  devise_for :users

  # プロトタイプ関連のルーティングを追加
  resources :prototypes do
    resources :comments, only: :create
  end
  resources :users, only: :show
  
  # ルートパスの設定
  root to:"prototypes#index"
end