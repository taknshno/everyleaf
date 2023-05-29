Rails.application.routes.draw do
  root 'tasks#index'

  resources :tasks do
    collection do
      get :search
    end
  end

  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :sessions, only: [:new, :create, :destroy]

  namespace :admin do
    resources :users do
      member do
        get :control
      end
    end

    resources :labels
  end
end
