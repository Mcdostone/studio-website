Rails.application.routes.draw do

  resources :albums
  resources :sessions, only: [:new, :create]
  root 'public#index'
  get "/auth/google_oauth2", as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'admin/', to: 'admin#index'
  get 'auth/failure', to: redirect('/')
  get 'hacker', to: 'public#hacker', as: 'hacker'
  get 'soon', to: 'public#soon', as: 'soon'


  resources :sessions, only: [:create, :destroy]
  resources :tags, only: [:show]
  resources :users, only: [:index, :show, :edit, :update]
  resources :albums, only: [:index, :show]
  resources :types, only: [:index, :show]
  resources :media, only: [:index] do
    member do
      get '/report', to: 'reports#new', as: "report"
      post '/report', to: 'reports#create'
    end
  end

  namespace :api do
    namespace :admin do
      resources :uploads, only: [:show]
      resources :media, only: [:index]
    end

    resources :media, only: [:index, :show] do
      member do
        post '/tag', to: 'media#tag', as: "tag"
        post '/like', to: 'media#like'
      end
    end
    resources :albums, only: [:show]
    resources :types, only: [:show]
    resources :tags, only: [:show]
    resources :users, only: [:show]
  end

  get '/feeds', to: 'activities#index'

  namespace :admin do
    resources :albums
    resources :types
    resources :tags, only: [:index, :destroy]
    resources :users, only: [:index, :edit, :update]
    resources :uploads, only: [:index, :new, :show, :create, :destroy, :video]

    resources :media, only: [:index, :edit, :update, :destroy] do
      member do
          delete '/untag/:id_tag', to: 'media#untag', as: 'untag'
          delete '/untagAll/', to: 'media#untag_all', as: 'untag_all'
      end
    end
      post '/uploads/video', to: 'uploads#video', as: 'upload_video'
    resources :reports, only: [:index, :show, :destroy] do
      member do
        post 'valid'
      end
    end
    get 'users/:id/ninja', to: 'users#ninja', as: 'ninja'
  end

  match '*path', to: 'public#not_found', via: :all, as:'not_found'
end
