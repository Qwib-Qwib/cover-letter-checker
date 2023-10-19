Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "pages#home"

  # Defines the root path for logged-in users
  # get '/user/:id' => "offers#index", as: :user_root

  # Defines routes related to offers' CRUD
  resources :offers, only: %i[index new create]
end
