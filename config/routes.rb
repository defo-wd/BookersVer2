Rails.application.routes.draw do
  devise_for :users
  get 'homes/top'
  root to: "homes#top"
  get 'home/about', to: 'homes#about', as: 'about'
  resources :users, only: [:show, :edit, :update, :index]
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
