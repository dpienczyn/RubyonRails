Rails.application.routes.draw do
  get 'pages/about'
  get 'pages/contact'
  get 'pages/projects'
  get 'settings/index'
  get 'password_resets/new'
  resources :posts do
    resources :comments
  end
  root 'posts#index'
  devise_for :users
  resources :subscribers, only: :create
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :posts, only: [:show, :index]
    end
  end
end
