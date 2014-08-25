Rails.application.routes.draw do

  devise_for :admins, controllers: { sessions: "admin/sessions" }
  resources :images, only: [:create, :destroy]
  resources :types, only: [:index, :show]
  resources :categories, only: [:index, :show]

  devise_for :users, path: ""
  resources :adverts do
    member do
      get 'in_moderate'
      get 'in_archive'
      get 'in_newest'
    end
  end

  root 'home#index'

  namespace :admin do
    resources :categories, only: [:index, :new, :edit, :create, :update]
    resources :adverts, only: :index do
      member do
        get 'in_reject'
        get 'in_publish'
      end
    end
    resources :users do
      member do
        get 'user_adverts_with_state'
      end
    end
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
