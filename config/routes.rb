Rails.application.routes.draw do
  devise_for :admins
  devise_for :end_users
  namespace :admin do
    get 'orders/index'
    get 'orders/show'
  end
  namespace :admin do
    get 'end_users/index'
    get 'end_users/show'
    get 'end_users/edit'
  end
  namespace :admin do
    get 'genres/index'
    get 'genres/edit'
  end
  namespace :admin do
    get 'items/index'
    get 'items/new'
    get 'items/show'
    get 'items/edit'
  end
  namespace :admin do
    get 'top/top'
  end
  namespace :public do
    get 'addresses/index'
    get 'addresses/edit'
  end
  namespace :public do
    get 'orders/new'
    get 'orders/confirm'
    get 'orders/complete'
    get 'orders/index'
    get 'orders/show'
  end
  namespace :public do
    get 'cart_items/index'
  end
  namespace :public do
    get 'end_users/show'
    get 'end_users/edit'
    get 'end_users/unsucribe'
  end
  namespace :public do
    get 'items/top'
    get 'items/index'
    get 'items/show'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
