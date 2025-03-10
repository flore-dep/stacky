Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :softwares do
    resources :licenses, only: %i[new create]
  end

  resources :licenses do
    resources :reviews, only: %i[new create]
  end

  resources :my_licenses, only: %i[index edit update]

  get 'my_profile', to: 'pages#profile'

  resources :my_softwares
end
