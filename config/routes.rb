Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :passengers do
      namespace :v1 do
        resources :flights, only: %i[show index]
      end
    end
    namespace :users do
      namespace :v1 do
        post 'auth/login', to: 'authentication#authenticate'
        post 'signup', to: 'users#create'
      end
    end
  end
end
