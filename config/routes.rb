Rails.application.routes.draw do

  root to: 'home#top'
  get 'home/about',as: 'about'
  # 管理者関連
  devise_for :admins, :controllers => {
    :sessions => 'admins/sessions'
  }

  devise_scope :admin do
    get 'dashboard', :to => 'dashboard#index'
    get 'dashboard/login', :to => 'admins/sessions#new'
    post 'dashboard/login', :to => 'admins/sessions#create'
    delete 'dashboard/logout', :to => 'admins/sessions#destroy'
  end

  # URLは指定のパスにしたい,ファイル構成も指定のパスにしたいとき、namescope
  # URLは指定のパスにしたい,ファイル構成変えたくないとき、scope

  namespace :dashboard do
    resources :users, only: [:index, :destroy]
    resources :categories, except: [:new]
    resources :products, except: [:show] do
      collection do
        get  'import/csv', :to => 'products#import'
        post 'import/csv', :to => 'products#import_csv'
        get  'import/csv_download', :to => 'products#download_csv'
        get  '/favorite', :to => 'products#favorite_users'
      end
    end
    resources :orders, only: [:index]
  end

  # 商品関連
  resources :products do
    resources :reviews, only: [:index, :create]
    member do
      get :favorite
    end
  end

  #検索
  get '/search', to: 'searches#search'

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
    get 'signup', :to => 'users/registrations#new'
    get 'login', :to => 'users/sessions#new'
    delete 'logout', :to => 'users/sessions#destroy'
    #ゲストログイン
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # userに関するページ

  resource :users, only: [:show] do
    collection do
      get 'cart', :to => 'shopping_carts#index'
      post 'cart/create', :to => 'shopping_carts#create'
      #商品１個ずつ削除
      delete 'cart/:id', :to => 'shopping_carts#delete_item', as: 'cart_delete'
      #カートを空にする
      delete 'deletecart', :to => 'shopping_carts#all_destroy'
      #購入する
      delete 'cart', :to => 'shopping_carts#destroy'
      #アカウント情報の変更
      get 'mypage/show', :to => 'users#show'
      #マイページ
      get 'mypage', :to => 'users#mypage'
      #パスワード
      get 'mypage/edit_password', :to =>'users#edit_password'
      put 'mypage/password', :to => 'users#update_password'
      #お気に入り
      get  'mypage/favorite', :to => 'users#favorite'
      #退会
      delete 'mypage/delete', :to => 'users#destroy'
      #購入履歴 indexとshow
      get 'mypage/purchases', :to => 'purchases#index',:as => 'mypage_purchases'
      get 'mypage/purchases/:num', :to => 'purchases#show', :as => 'mypage_purchase'
      #クレジットカード登録
      get    'mypage/register_card',     :to => 'users#register_card'
      post   'mypage/token',             :to => 'users#token'
    end
  end

  #お問い合わせ

  resources :contacts, only: [:new, :create]
  post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
  post 'contacts/back', to: 'contacts#back', as: 'back'
  get 'done', to: 'contacts#done', as: 'done'
end
