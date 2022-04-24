Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "products#index"

  resources :products do
    resources :reviews, only: [:create]
    member do
      get :favorite
    end
  end

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :confirmations => 'users/confirmations',
    :unlocks => 'users/unlocks',
  }

  devise_scope :user do
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    delete "logout", :to => "users/sessions#destroy"
  end

  resource :users, only: [:show] do
    collection do
      get "mypage/show", :to => "users#show"
      get "mypage", :to => "users#mypage"
      get "mypage/edit_password", :to =>"users#edit_password"
      put "mypage/password", :to => "users#update_password"
    end
  end


end
