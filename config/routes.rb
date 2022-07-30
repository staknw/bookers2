Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "/home/about" => "homes#about", as: "about"
  resources :books, only: [:new, :index, :show, :edit, :update, :create, :destroy]
  # ↑get 'books/new'
  # get 'books/index'
  # get 'books/show'

  resources :users, only: [:new, :index, :show, :edit, :update, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
