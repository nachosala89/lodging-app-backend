Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
     resources :rooms, only: [:index, :show, :create, :destroy]
     resources :reservations, only: [:index, :show, :create]
     resources :cities, only: [:index] do
      resources :hotels, only: [:index]
     end
     post 'login', to: 'authentication#authenticate'
     post 'signup', to: 'users#create'
    end
  end
end
