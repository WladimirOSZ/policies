Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  post "/graphql", to: "graphql#execute"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get "policies", to: "policies#index"
  resources :policies, only: %i[index, show]
end
