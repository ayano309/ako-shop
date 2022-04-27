Rails.application.routes.draw do
  
  get 'purchases/index'
  get 'purchases/show'
  # 管理者関連
  devise_for :admins, :controllers => {
    :sessions => 'admins/sessions'
  }

  devise_scope :admin do
    get "dashboard", :to => "dashboard#index"
    get "dashboard/login", :to => "admins/sessions#new"
    post "dashboard/login", :to => "admins/sessions#create"
    delete "dashboard/logout", :to => "admins/sessions#destroy"
  end

  # URLは指定のパスにしたい,ファイル構成も指定のパスにしたいとき、namescope
  # URLは指定のパスにしたい,ファイル構成変えたくないとき、scope

  namespace :dashboard do
    resources :users, only: [:index, :destroy]
    resources :categories, except: [:new]
    resources :products, except: [:show] do
      collection do
        get  "import/csv", :to => "products#import"
        post "import/csv", :to => "products#import_csv"
        get  "import/csv_download", :to => "products#download_csv"
      end
    end
    resources :orders, only: [:index]
  end
  

  # 商品関連
  root to: "products#index"
  resources :products do
    resources :reviews, only: [:create]
    member do
      get :favorite
    end
  end

  
  # user関連
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :confirmations => 'users/confirmations',
    :unlocks => 'users/unlocks',
  }

  # userのサインアップなど

  devise_scope :user do
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    delete "logout", :to => "users/sessions#destroy"
  end

  # userに関するページ

  resource :users, only: [:show] do
    collection do
      get "cart", :to => "shopping_carts#index"
      post "cart/create", :to => "shopping_carts#create"
      delete "cart", :to => "shopping_carts#destroy"
      get "mypage/show", :to => "users#show"
      get "mypage", :to => "users#mypage"
      get "mypage/edit_password", :to =>"users#edit_password"
      put "mypage/password", :to => "users#update_password"
      get  "mypage/favorite", :to => "users#favorite"
      delete "mypage/delete", :to => "users#destroy"
      get "mypage/purchases", :to => "purchases#index"
    end
  end


end
