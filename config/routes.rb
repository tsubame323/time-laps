Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  
  
    get 'signup', to: 'users#new'
  resources :users, only: [:show, :create] do
    member do
      get :likes
    end
  end
  resources :folders, only: [:create,:show, :index,:destroy] do
      resources :photos, only: [:create,:destroy,:show] do
        resources :comments, only: [:create, :destroy]
      end
        collection do
get :fav
get :lotsPost
get :search
end
  end
  

  
  resources :favorites, only: [:create, :destroy]
end