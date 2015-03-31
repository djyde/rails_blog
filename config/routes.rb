Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'
  resources :posts
  get 'archive', to: 'posts#archive'
  get 'about', to: 'posts#about'
end
