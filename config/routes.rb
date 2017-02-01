Rails.application.routes.draw do

#  resources :reports
  #resources :likes
  root 'public#index'
  
  get "/auth/google_oauth2", as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'admin/', to: 'admin#index'
  get 'auth/failure', to: redirect('/')

  resources :sessions, only: [:create, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
  resources :events, only: [:index, :show]
  resources :types, only: [:index, :show]
  
  resources :media, only: [:index, :show] do
    member do
      #post 'like'
      resources :reports, only: [:new, :create]
    end
  end


  namespace :admin do
    resources :events
    resources :uploads, only: [:index, :new, :show, :create]
    resources :types
    resources :reports, only: [:index, :show, :destroy]
    resources :media, only: [:index, :edit, :update, :destroy]
    resources :users, only: [:index, :edit, :update]
    get 'users/:id/ninja', to: 'users#ninja', as: 'ninja'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
