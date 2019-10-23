Rails.application.routes.draw do
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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
