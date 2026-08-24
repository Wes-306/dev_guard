# config/routes.rb
Rails.application.routes.draw do
  # Health check nativo do Rails
  get "up" => "rails/health#show", as: :rails_health_check

  # Página inicial da aplicação (Dashboard)
  root "dashboard#index"

  # Rotas para gestão de sessão (Autenticação)
  get    "login",  to: "sessions#new",     as: :login
  post   "login",  to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout
end