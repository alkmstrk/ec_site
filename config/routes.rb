Rails.application.routes.draw do
  devise_for :admins
  devise_for :end_users

  get '/' => 'public/items#top', as: :root
  get '/end_users/my_page' => 'public/end_users#show'
  get '/end_user/edit' => 'public/end_users#edit'
  patch '/end_user/' => 'public/end_users#update'
  # 退会確認画面
  get '/end_users/unsucribe' => 'public/end_users#unsucribe'
  # 退会処理/論理削除
  patch '/end_users/is_deleted' => 'public/end_users#is_deleted'

  namespace :admin do
    root 'top#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :end_users, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
  end


  scope module: :public do
    # 商品
    resources :items, only: [:index, :show]
    # カート内商品
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete :clear # 一括削除
      end
    end
    # 購入履歴
    resources :orders, only: [:new, :index, :show, :create] do
      collection do
        get :confirm #購入情報確認画面
        get :complete #購入完了画面
      end
    end
    # 配送先
    resources :addresses, only: [:index, :edit, :update, :create, :destroy]

    resources :purchases_histories, only: [:index, :show, :new, :create, :destroy]
    resources :contacts, only: [:new, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
