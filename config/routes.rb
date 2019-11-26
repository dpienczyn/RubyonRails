Rails.application.routes.draw do
  get 'settings/index'
  get 'password_resets/new'
  resources :posts do
    resources :comments
  end
  root 'posts#index'
  devise_for :users, skip: [:sessions]
  as :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    post 'sign_up', to: 'devise/sessions#create', as: :user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  controller :pages do
    get 'pages/about'
    get 'pages/contact'
    get 'pages/projects'
  end
  resources :subscribers, only: [:create, :index]
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :posts, only: [:show, :index]
      resources :subscribers, only: [:create, :index]
    end
  end
end
