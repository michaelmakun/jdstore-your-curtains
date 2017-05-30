Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :sessions      => "users/sessions",
    :registrations => "users/registrations",
    :passwords     => "users/passwords",
    :omniauth_callbacks => "omniauth_callbacks",
  }

  mount ChinaCity::Engine => '/china_city'

  root 'welcome#index'

  resources :products do
    resources :reviews
    member do
      get :add_to_cart
      post :add_favorite
      post :cancel_favorite
    end
    collection do
      get :search
    end
  end

  namespace :admin do
    resources :categories
    resources :products
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end

  resources :carts do
    collection do
      delete :clean
      post :checkout
    end
  end

  resources :cart_items

  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
  end

  namespace :account do
    resources :orders
  end
end
