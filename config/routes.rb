Rails.application.routes.draw do
  resources :images, only: [:create, :destroy]
  resources :types, only: [:index, :show]
  resources :categories, only: [:index, :show]

  devise_for :users, path: "", :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations" }
  resources :adverts do
    member do
      get 'in_moderate'
      get 'in_archive'
      get 'in_newest'
    end
  end

  root 'home#index'

  devise_for :admins, path: "admin", controllers: { sessions: "admin/sessions" }, :skip => [:registrations]
    as :admin do
      get 'admin/edit' => 'admin/registrations#edit', :as => 'edit_admin_registration'
      put 'admin/' => 'admin/registrations#update', :as => 'admin_registration'
    end
  namespace :admin do
    root 'adverts#index'
    resources :categories, only: [:index, :new, :edit, :create, :update]
    resources :adverts, only: [:index, :show] do
      resources :logs, only: [:new, :create, :index]
      member do
        get 'in_publish'
      end
    end
    resources :users do
      member do
        get 'user_adverts_with_state'
      end
    end
  end
end
