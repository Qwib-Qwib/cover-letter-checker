Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "pages#home"

  # Defines the root path for logged-in users
  # get '/user/:id' => "offers#index", as: :user_root

  # Defines routes related to offers' CRUD, with routes related to job applications' CRUD nested inside them.
  resources :offers, only: %i[index show new create] do
    resources :job_applications, only: %i[show new create]
  end
end
