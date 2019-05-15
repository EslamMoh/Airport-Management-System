Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :passengers do
      namespace :v1 do
        resources :flights, only: %i[show index]
        resources :tickets, only: %i[index show create]
        post 'tickets/:id', to: 'tickets#confirm'
        post 'auth/login', to: 'authentication#authenticate'
        post 'signup', to: 'passengers#create'
        get 'passenger', to: 'passengers#show'
      end
    end
    namespace :users do
      namespace :v1 do
        resources :airports, only: %i[index show update create destroy]
        resources :airlines, only: %i[index show update create]
        resources :airplanes, only: %i[index show update create destroy]
        resources :flights, only: %i[index show update create destroy]
        resources :flight_executions, only: %i[index show update create destroy]
        delete 'airlines/:airport_id/:id', to: 'airlines#destroy'
        delete 'terminals/:airport_id/:id', to: 'terminals#destroy'
        delete 'flights/flight_executions/:id/:flight_execution_id', to: 'flights#remove_flight_execution'
        put 'terminals/:airport_id/:id', to: 'terminals#update'
        post 'flights/flight_executions/:id', to: 'flights#add_flight_executions'
        post 'airport_airlines/:airport_id/:id', to: 'airlines#add_airport_airlines'
        post 'auth/login', to: 'authentication#authenticate'
        post 'signup', to: 'users#create'
        post 'terminals/:airport_id', to: 'terminals#create'
        get 'terminals/:airport_id', to: 'terminals#index'
        get 'terminals/:airport_id/:id', to: 'terminals#show'
        get 'user', to: 'users#show'
      end
    end
  end
end
