Rails.application.routes.draw do
  root "sessions#new"  # 👈 this makes / go to login

  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, only: [:new, :create]
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :quizzes
end
