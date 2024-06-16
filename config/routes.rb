Rails.application.routes.draw do
  get 'rails/server'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :locations
  resources :warehouses
  resources :stations, only: [:index, :show] do
    member do
      get 'available_power_banks'
      post 'take_power_bank/:power_bank_id', action: :take_power_bank, as: :take_power_bank
      post 'return_power_bank/:power_bank_id', action: :return_power_bank, as: :return_power_bank
    end
  end
  resources :power_banks do
    member do
      post 'assign_to_station/:station_id', action: :assign_to_station, as: :assign_to_station
      post 'assign_to_warehouse/:warehouse_id', action: :assign_to_warehouse, as: :assign_to_warehouse
      post 'assign_to_user/:user_id', action: :assign_to_user, as: :assign_to_user
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
