Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
  devise_scope :user do
    get "profile", to: "users/registrations#show"
    get "dashboard", to: "users/dashboard#show"
    post "account", to: "users/account#create"
    post "transaction", to: "users/transaction#create"
  end
end
