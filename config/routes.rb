Rails.application.routes.draw do
  get 'settings/index'
  get 'password_resets/new'
  get 'project/index'
  get 'projects/index'
  get 'contact/index'
  resources :posts do
    resources :comments
  end
  get 'homeapp/index'
  root 'posts#index'
  get 'home/about'
  get 'contact/index'
  devise_for :users
  resources :subscribers, only: :create
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :post, only: [:show, :index]
    end
  end
end
